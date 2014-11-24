class SubscriptionsController < ApplicationController

  def create
    find_or_create(params[:subscription])
    redirect_to root_path
  end

  def destroy
    # sub_params = params[:subscription]
    subs = Subscription.where(uid: params[:uid], provider: params[:provider])[0]
    if current_bro.subscriptions.include? subs
      current_bro.subscriptions.destroy(subs.id)
    end
    redirect_to :back
  end

  private

  def find_or_create(subs_hash)
    # TODO: refactor to get a single instance instead of the first thing in the array
    subscrip = Subscription.where(uid: subs_hash[:uid], provider: subs_hash[:provider] )[0]
    if subscrip.nil?
      subscrip = Subscription.create(uid: subs_hash[:uid], provider: subs_hash[:provider])
    end
    # at some point the subscribe button will not exist if bro already has subscription
    unless current_bro.subscriptions.include? subscrip
      current_bro.subscriptions << subscrip
    end
  end


end
