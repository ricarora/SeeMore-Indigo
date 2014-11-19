class User < ActiveRecord::Base
  has_many :authentications
  has_and_belongs_to_many :subscriptions

end
