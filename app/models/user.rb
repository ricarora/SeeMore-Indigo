class User < ActiveRecord::Base
  has_many :authentications
  has_and_belongs_to_many :subscriptions
  has_many :feed_items, through: :subscriptions

  #returns an array of provider types linked with the user
  def providers
    authentications.collect do |auth|
      auth.provider
    end
  end
end
