class PagesController < ApplicationController

  def index
    unless current_bro
      render :landing
    end
  end

  def twitter_auth

  end

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
