class PagesController < ApplicationController

  def index
    if current_bro
      load_feed
    else
      render :landing
    end
  end

  def twitter_auth

  end

  #possibly this should be moved to another controller or in a model (user)???
  def load_feed
    # each item in the feed is a hash that has this:
    # provider_image_url, avatar, username, created_at, content
    @feed = []
    current_bro.subscriptions.each do |subs|
      case subs.provider
      when "twitter"
        tweets = $client.user_timeline(subs.uid.to_i)
        add_tweets_to_feed(tweets)
      #when "vimeo"
      end
    end
    @feed.sort_by! {|item| item[:created_at]}
    @feed.reverse!
  end

  def add_tweets_to_feed(tweets)
    tweets.each do |tweet|
      @feed << {
        provider_image_url: "twitter-64-black.png",
        avatar: tweet.user.profile_image_url.to_s,
        username: "@"+tweet.user.username,
        created_at: tweet.created_at,
        content: tweet.full_text
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
