require 'rails_helper'
describe SubscriptionsController, :type => :controller do

  describe "#destroy" do
    before {User.create(name: "meow", email: "cat@meow.com")}
    before { session[:bro_id] = User.first.id }
    it "removes the subscription-user relationship" do
      user = User.find(session[:bro_id])
      user.subscriptions << Subscription.create(uid: "1621062337", provider: "twitter")
      get :destroy, {subscription: {provider: "twitter", uid: "1621062337"} }
      expect(user.subscriptions.count).to eq(0)
      # why does this test pass, but (user.subscriptions).to_be empty doesn't???
    end
  end

end
