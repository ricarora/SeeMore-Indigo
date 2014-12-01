class SubscriptionsController < ApplicationController

  def create
    subs_hash = params[:subscription]
    if subs_hash[:provider] == "instagram" && insta_user_is_private?(subs_hash[:uid])
      respond_to do |format|
        format.js { redirect_to root_path, notice: "Account is private" }
      end
    elsif subs_hash[:provider] == "twitter" && subs_hash[:protected] == true
      raise
    else
      find_or_create(subs_hash)
    end
    respond_to do |format|
      format.html {render html: "success"}
      format.js
    end
  end

  #this destroys the connection between a subscription and a user, but not the actual subscription
  def destroy
    sub_params = params[:subscription]
    subs = Subscription.where(uid: sub_params[:uid], provider: sub_params[:provider])[0]
    if current_bro.subscriptions.include? subs
      current_bro.subscriptions.destroy(subs.id)
    end
    respond_to do |format|
      format.html {render html: "unsubscribe"}
      format.js
    end
  end

  private

  def find_or_create(subs_hash)
    subscrip = Subscription.where(uid: subs_hash[:uid], provider: subs_hash[:provider] )[0]
    if subscrip.nil?
      subscrip = Subscription.create(uid: subs_hash[:uid],
                                     provider: subs_hash[:provider],
                                     avatar_url: subs_hash[:avatar_url],
                                     username: subs_hash[:username],
                                     display_name: subs_hash[:name])
    end
    unless current_bro.subscriptions.include? subscrip
      current_bro.subscriptions << subscrip
    end
  end

  def insta_user_is_private?(uid)
    # access_token = session[:access_token]
    client_id = ENV["INSTAGRAM_CLIENT_ID"]
    response = HTTParty.get("https://api.instagram.com/v1/users/#{uid}?client_id=#{client_id}")
    response.code == 400 ? true : false
    # return false
  end


end
