class PagesController < ApplicationController
  skip_before_filter :logged_in, only: :landing

  def index
    load_feed
  end

  def landing
    render :layout => false
  end

  def update_twitter_subscription(subscription)
    user = $client.user(subscription.uid.to_i)
    subscription.update(avatar_url: user.profile_image_url.to_s,
                        username: user.screen_name,
                        display_name: user.name
                        )
    tweets = $client.user_timeline(subscription.uid.to_i)
    tweets.each do |tweet|
      unless subscription.feed_items.find_by_post_id(tweet.id.to_s)
        subscription.feed_items.create(content: tweet.full_text,
                                       post_time: tweet.created_at,
                                       post_id: tweet.id)
      end
    end
  end

  def update_vimeo_subscription(subscription)
    user = Vimeo::Simple::User.info(subscription.uid.to_i)
    subscription.update(avatar_url: user["portrait_medium"],
                        username: user["profile_url"].gsub("https://vimeo.com/", ""),
                        display_name: user["display_name"]
                        )
    videos = Vimeo::Simple::User.all_videos(subscription.uid.to_i)
    videos.each do |video|
      unless subscription.feed_items.find_by_post_id(video["id"].to_s)
        subscription.feed_items.create(content: video["url"].gsub("https://vimeo.com/", ""),
                                       post_time: video["upload_date"],
                                       post_id: video["id"])
      end
    end
  end

  #possibly this should be moved to another controller or in a model (user)???
  def load_feed
    current_bro.subscriptions.each do |subscription|
      case subscription.provider
      when "twitter"
        update_twitter_subscription(subscription)
      when "vimeo"
        update_vimeo_subscription(subscription)
      end
      @feed = current_bro.feed_items
      @feed.order(post_time: :asc)

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
      @results = Beemo::User.search(srch)
      render :vimeo_results
    else
      render :user_search
    end
  end

end
