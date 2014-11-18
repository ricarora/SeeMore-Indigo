class PagesController < ApplicationController

  def index
  end

  def twitter_auth

  end

  def twitter_user_search
    srch = params[:search]
    if srch.length > 0
      @results = $client.user_search(srch).first(10)
    # raise
    end
    render :twitter_search
  end

end
