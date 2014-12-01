require 'rails_helper'
describe PagesController, :type => :controller do
  # before {User.create(name: "meow", email: "cat@meow.com")}
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

      #what is this test for? it only passes because of a test in the sessions_controller_spec
      xit "there is a user" do
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
      it 'renders the twitter search results when twitter is searched' do
        user = User.create
        session[:bro_id] = user.id

        get :user_search, {provider: "Twitter", search: "bookis"}
        expect(response).to render_template("twitter_results")
      end

      it "populates a results array when twitter is searched" do
        user = User.create
        session[:bro_id] = user.id

        get :user_search, {provider: "Twitter", search: "bookis"}
        expect(assigns(:results)).to_not be_nil
      end

      it 'has bookis in the result when twitter is searched for "bookis"' do
        user = User.create
        session[:bro_id] = user.id
        get :user_search, {provider: "Twitter", search: "bookis"}
        expect(assigns(:results).collect {|twitter_user| twitter_user.screen_name}).to include("bookis")
      end

      it 'renders the vimeo search results when vimeo is searched' do
        user = User.create
        session[:bro_id] = user.id

        get :user_search, {provider: "Vimeo", search: "bookis"}
        expect(response).to render_template("vimeo_results")
      end

      it 'has teamtreehouse in the result when vimeo is searched for treehouse' do
        user = User.create
        session[:bro_id] = user.id
        get :user_search, {provider: "Vimeo", search: "treehouse"}
        expect(assigns(:results).collect {|vimeo_user| vimeo_user.url.gsub("https://vimeo.com/", "")}).to include("teamtreehouse")
      end

      it 'renders the instagra, search results when instagram is searched' do
        user = User.create
        session[:bro_id] = user.id

        get :user_search, {provider: "Instagram", search: "bookis"}
        expect(response).to render_template("instagram_results")
      end

      it 'has cats_of_instagram in the result when instagram is searched for "cats"' do
        user = User.create
        session[:bro_id] = user.id
        get :user_search, {provider: "Instagram", search: "cats"}
        expect(assigns(:results).collect {|instagram_user| instagram_user.username}).to include("cats_of_instagram")
      end
    end

  end
end
