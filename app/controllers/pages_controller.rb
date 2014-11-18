class PagesController < ApplicationController

  def index
  end

  def twitter_auth

  end

  def twitter_user_search
    @results = $client.user_search(params[:search]).first(10)
    # raise
    render :twitter_search
  end

end
