class SubscriptionsController < ApplicationController

  def create
    find_or_create(params[:subscription])
    respond_to do |format|
      format.html {render html: "success"}
      format.js
    end

  end

  def bad
    #this method is never used, but the route is needed
    #when rails makes a form_for it needs to 
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
    # TODO: refactor to get a single instance instead of the first thing in the array
    subscrip = Subscription.where(uid: subs_hash[:uid], provider: subs_hash[:provider] )[0]
    if subscrip.nil?
      # if subs_hash[:provider] == "instagram" && insta_user_is_private?(subs_hash[:uid])
      #     #print error message
      # else
        subscrip = Subscription.create(uid: subs_hash[:uid],
                                       provider: subs_hash[:provider],
                                       avatar_url: subs_hash[:avatar_url],
                                       username: subs_hash[:username],
                                       display_name: subs_hash[:name])
      # end
    end
    # at some point the subscribe button will not exist if bro already has subscription
    unless current_bro.subscriptions.include? subscrip
      current_bro.subscriptions << subscrip
    end
  end

  def insta_user_is_private?(uid)
    response = HTTParty.get('https://api.instagram.com/v1/users/#{uid}/relationship')
    response.code == 400 ? true : false
  end


end
