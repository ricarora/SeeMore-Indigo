class PagesController < ApplicationController
  skip_before_filter :logged_in, only: :landing

  def index
    load_feed
  end

  def landing
    render :layout => false
  end

  def update_twitter_subscription(subscription)
    # update subscription info (avatar_url, username, display_name)
    user = $client.user(subscription.uid.to_i)
    subscription.update(avatar_url: user.profile_image_url.to_s,
                        username: user.screen_name,
                        display_name: user.name
                        )
    # use the pertinent api to grab feed items
    tweets = $client.user_timeline(subscription.uid.to_i)
    # add any feed items that are new to the subscription's feed items
    tweets.each do |tweet|
      # if not in subscription.feed_items make a new feed_item and add it
      unless subscription.feed_items.find_by_post_id(tweet.id)
        raise
        subscription.feed_items.create()
      end
    end
    # don't add duplicates
  end

  #possibly this should be moved to another controller or in a model (user)???
  def load_feed
    # go through each of the user's subscriptions
    current_bro.subscriptions.each do |subscription|
      case subscription.provider
      when "twitter"
        update_twitter_subscription(subscription)
      when "vimeo"
      end


    # fill user's @feed with feed items
    # also sort feed, newest to oldest

    end


    # each item in the feed is a hash that has this:
    # provider_image_url, avatar, username, created_at, content
    # @feed = []
    # current_bro.subscriptions.each do |subscription|
    #   case subscription.provider
    #   when "twitter"
    #     tweets = $client.user_timeline(subscription.uid.to_i)
    #     add_tweets_to_feed(tweets)
    #   when "vimeo"
    #     videos = Vimeo::Simple::User.all_videos(subscription.uid.to_i)
    #     add_videos_to_feed(videos)
    #   end
    # end
    # @feed.sort_by! {|item| item[:created_at]}
    # @feed.reverse!
  end

  def add_tweets_to_feed(tweets)
    tweets.each do |tweet|
      @feed << {
        provider: "twitter",
        provider_image_url: "twitter-64.png",
        avatar: tweet.user.profile_image_url.to_s,
        username: "@"+tweet.user.screen_name,
        created_at: tweet.created_at,
        content: tweet.full_text
        }
    end
  end

  def add_videos_to_feed(videos)
    videos.each do |video|
      @feed << {
        provider: "vimeo",
        provider_image_url: "vimeo-64.png",
        avatar: video["user_portrait_medium"],
        username: video["user_url"].gsub("https://vimeo.com/", ""),
        created_at: video["upload_date"],
        content: video["id"]
      }
    end
  end

  def user_search
    @subscription = Subscription.new
    srch = params[:search]
    if params[:provider] == "Twitter" && srch.length > 0
        @results = $client.user_search(srch).first(10)
        render :twitter_results
    elsif params[:provider] == "Vimeo" && srch.length > 0
      @results = Vimeo::Simple::User.info(srch)
      render :vimeo_results
    else
      render :user_search
    end
  end

end
