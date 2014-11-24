class PagesController < ApplicationController
  skip_before_filter :logged_in, only: :landing

  def index
    load_feed
  end

  def landing
    render :layout => false
  end

  def twitter_auth

  end

  #possibly this should be moved to another controller or in a model (user)???
  def load_feed
    # each item in the feed is a hash that has this:
    # provider_image_url, avatar, username, created_at, content
    @feed = []
    current_bro.subscriptions.each do |subscription|
      case subscription.provider
      when "twitter"
        tweets = $client.user_timeline(subscription.uid.to_i)
        add_tweets_to_feed(tweets)
      when "vimeo"
        videos = Vimeo::Simple::User.all_videos(subscription.uid.to_i)
        add_videos_to_feed(videos)
      end
    end
    @feed.sort_by! {|item| item[:created_at]}
    @feed.reverse!
  end

  def add_tweets_to_feed(tweets)
    tweets.each do |tweet|
      @feed << {
        provider: "twitter",
        provider_image_url: "twitter-64.png",
        avatar: tweet.user.profile_image_url.to_s,
        username: "@"+tweet.user.username,
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
    request.env["HTTP_REFERER"]
    if srch && srch.length > 0
      case params[:provider]
      when "Twitter"
        @results = $client.user_search(srch).first(10)
        render :twitter_results
      when "Vimeo"
        @results = Beemo::User.search(srch)
        render :vimeo_results
      when "Instagram"
        raise
        render :instagram_results
      end
    else
      #TODO this will bug if you search for nothing on a search results page
      redirect_to :back
    end
  end

end
