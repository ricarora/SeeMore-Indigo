require 'rails_helper'
describe PagesController, :type => :controller do
  before(:all) { User.create(name: "meow", email: "cat@meow.com") }
  describe "#index" do
    context "user is logged out" do
      before { session[:bro_id] = nil }
      it "redirects to landing page" do
        get :index
        expect(response).to redirect_to("/watup")
      end
    end

    context "user is logged in" do
      before { session[:bro_id] = User.first.id }
      it "it is successful" do
        get :index
        expect(response.status).to eq 200
      end

      #what is this test for? it only passes because of a test in the sessions_controller_spec
      xit "there is a user" do
        get :index
        expect(User.count).to eq 1
      end

      it "loads the user's feed" do
        user = User.find(session[:bro_id])
        subscription = Subscription.create
        subscription.feed_items.create
        user.subscriptions << subscription

        get :index
        expect(assigns(:feed)).to_not be_nil
      end

      it 'adds feed_items to a user\'s twitter subscription' do
        user = User.find(session[:bro_id])
        subscription = Subscription.create(
          provider: "twitter",
          uid: "1002706964")
        user.subscriptions << subscription

        get :index
        expect(user.feed_items).to_not be_empty
      end
    end
  end

  describe "#landing" do
    context "user is logged out" do
      before { session[:bro_id] = nil }
      it 'renders the landing page' do
        get :landing
        expect(response).to render_template("landing")
      end
    end

    context "user is logged in" do
      before { session[:bro_id] = User.first.id }
      it 'a logged in user cannot view the landing page' do
        get :landing
        expect(response).to redirect_to("/")
      end
    end

  end

  describe  "#user_search" do
    context "user is logged in" do
      before { session[:bro_id] = User.first.id }
      it 'renders the correct page when any provider is searched' do

        providers = ["Twitter", "Vimeo", "Instagram"]

        providers.each do |provider|
          get :user_search, {provider: provider, search: "bookis"}
          expect(response).to render_template("#{provider.downcase}_results")
        end
      end

      it "populates a results array when twitter is searched" do
        get :user_search, {provider: "Twitter", search: "bookis"}
        expect(assigns(:results)).to_not be_nil
      end

      it 'has bookis in the result when twitter is searched for "bookis"' do
        get :user_search, {provider: "Twitter", search: "bookis"}
        expect(assigns(:results).collect(&:screen_name)).to include("bookis")
      end

      it 'has teamtreehouse in the result when vimeo is searched for treehouse' do
        get :user_search, {provider: "Vimeo", search: "teamtreehouse"}
        expect(assigns(:results).collect {|vimeo_user| vimeo_user.url.gsub("https://vimeo.com/", "")}).to include("teamtreehouse")
      end

      it 'has cats_of_instagram in the result when instagram is searched for "cats"' do
        get :user_search, {provider: "Instagram", search: "cats"}
        expect(assigns(:results).collect(&:username)).to include("cats_of_instagram")
      end
    end

  end
end
