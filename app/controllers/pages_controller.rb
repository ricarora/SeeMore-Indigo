class PagesController < ApplicationController

  def index
    unless current_bro
      render :landing
    end
  end

  def twitter_auth

  end

  def user_search
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
