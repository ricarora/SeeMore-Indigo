class SubscriptionsController < ApplicationController

  def create
    find_or_create(params[:subscription])
    respond_to do |format|
      format.html {render html: "success"}
      format.js
    end

  end

  private

  def find_or_create(subs_hash)
    # TODO: refactor to get a single instance instead of the first thing in the array
    subscrip = Subscription.where(uid: subs_hash[:uid], provider: subs_hash[:provider] )[0]
    if subscrip.nil?
      subscrip = Subscription.create(uid: subs_hash[:uid],
                                     provider: subs_hash[:provider],
                                     avatar_url: subs_hash[:avatar_url],
                                     username: subs_hash[:username],
                                     display_name: subs_hash[:name])
    end
    # at some point the subscribe button will not exist if bro already has subscription
    unless current_bro.subscriptions.include? subscrip
      current_bro.subscriptions << subscrip
    end
  end


end
