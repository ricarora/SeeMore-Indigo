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
      @feed = current_bro.feed_items.order(post_time: :desc)
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
        insta_client = Instagram.client(:access_token => session[:access_token])
        @results = insta_client.user_search(srch)
        render :instagram_results
      end
    else
      # if you use redirect_to :back, it crashes when you search for an empty
      # string on a search results page
      redirect_to :root_path
    end
  end

end
