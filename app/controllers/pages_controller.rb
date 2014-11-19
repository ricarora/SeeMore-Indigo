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
    @tweets = []
    current_bro.subscriptions.each do |subs|
      #later we'll need to check the provider first
      @tweets += $client.user_timeline(subs.uid.to_i)
    end
  end

  #provider image, user image, username, content

  def twitter_user_search
    @subscription = Subscription.new
    srch = params[:search]
    if srch.length > 0
      @results = $client.user_search(srch).first(10)
    # raise
    end
    render :twitter_search
  end

end
