class SubscriptionsController < ApplicationController

  def create
    find_or_create(params[:subscription])
    redirect_to root_path
  end

  private

  def find_or_create(subs_hash)
    subscrip = Subscription.where(uid: subs_hash[:uid], provider: subs_hash[:provider] )
    if subscrip.empty?
      subscrip = Subscription.create(uid: subs_hash[:uid], provider: subs_hash[:provider])
    end
    unless current_bro.subscriptions.include? subscrip
      current_bro.subscriptions << subscrip
    end
  end


end
