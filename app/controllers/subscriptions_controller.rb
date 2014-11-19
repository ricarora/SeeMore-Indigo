class SubscriptionsController < ApplicationController

  def create
    find_or_create(params[:subscription])
    raise
  end

  private

  def find_or_create(subs_hash)
    subscrip = Subscription.where(uid: subs_hash[:uid], provider: subs_hash[:provider] )
    if subscrip.empty?
      subscrip = Subscription.create(uid: subs_hash[:uid], provider: subs_hash[:provider])
    end
    current_bro.subscriptions << subscrip
  end


end
