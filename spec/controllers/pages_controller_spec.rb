require 'rails_helper'
describe PagesController, :type => :controller do
  before {User.create(name: "meow", email: "cat@meow.com")}
  describe "#index" do
    context "user is logged out" do
      before { session[:bro_id] = nil }
      it "redirects to landing page" do
        get :index
        expect(response).to redirect_to("/watup")
      end
    end
    context "user is logged in" do
      it "it is successful" do
        user = User.create
        session[:bro_id] = user.id
        get :index
        expect(response.status).to eq 200
      end
      it "there is a user" do
        get :index
        expect(User.count).to eq 1
      end
      it "loads the user's feed" do
        user = User.create
        subscription = Subscription.create
        subscription.feed_items.create
        user.subscriptions << subscription
        session[:bro_id] = user.id

        get :index
        expect(assigns(:feed)).to_not be_nil
      end
    end
  end
  describe  "#user_search" do
    context "user is logged in" do
      xit "renders twitter search results when twitter is searched" do
        user = User.create
        session[:bro_id] = user.id
        get :user_search, {}, {provider: "twitter", search: "something"}
        puts "******" + response.inspect
        expect(response).to render_template(:twitter_results)
      end
    end
  end
end
