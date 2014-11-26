class Subscription < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :feed_items

  def unsubscribe_msg
    msgs = ["Break it off", "End it", "Make a clean break", "Go no contact",
       "Slow fade", "Hit the gym", "It's you, not me"]
    msgs.sample
  end

end
