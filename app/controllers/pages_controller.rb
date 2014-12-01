class PagesController < ApplicationController
  skip_before_filter :logged_in, only: :landing

  def index
    load_feed
  end

  def landing
    render :layout => false
  end

  def user_search
    @subscription = Subscription.new
    srch = params[:search]
    # request.env["HTTP_REFERER"]
    provider = params[:provider]
    if srch && srch.length > 0
      search_for(srch, provider)
    else
      # if you use redirect_to :back, it crashes when you search for an empty
      # string on a search results page
      redirect_to root_path
    end
  end

  private

  def search_for(srch, provider)
    @results = ProviderSearch.search_for(srch, provider)
    render "#{provider}_results".downcase.to_s
  end

  def feed_item_maker(content, post_time, post_id, caption)
    FeedItem.create(content: content, post_time: post_time, post_id: post_id, caption: caption)
  end

  def load_feed
    current_bro.subscriptions.each do |subscription|
      case subscription.provider
      when "twitter"
        update_twitter_subscription(subscription)
      when "vimeo"
        update_vimeo_subscription(subscription)
      when "instagram"
        update_instagram_subscription(subscription)
      end
      @feed = current_bro.feed_items.order(post_time: :desc)
    end
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
        subscription.feed_items << feed_item_maker(tweet.full_text, tweet.created_at, tweet.id, nil)
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
        subscription.feed_items << feed_item_maker(video["url"].gsub("https://vimeo.com/", ""),
        video["upload_date"],
        video["id"],
        video["description"])
      end
    end
  end

  def update_instagram_subscription(subscription)
    insta_client = Instagram.client(:access_token => session[:access_token])
    instamedia = insta_client.user_recent_media(subscription.uid.to_i)
    user = instamedia.first.user
    subscription.update(avatar_url: user.profile_picture,
    username: user.username,
    display_name: user.full_name
    )
    instamedia.each do |instagram|
      unless subscription.feed_items.find_by_post_id(instagram[:id].to_s)
        subscription.feed_items << feed_item_maker(instagram["images"]["low_resolution"]["url"],
        DateTime.strptime(instagram["created_time"],'%s'),
        instagram[:id].to_s,
        instagram["caption"]["text"], )
      end
    end
  end

end
