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
      before { session[:bro_id] = 1 }
      # This test is failing, still need more research, feel free to work on this.
      # This is more approachable than the test on sessions_controller_spec.
      xit "it is successful" do
        get :index, {}, {:bro_id => 1}
        # puts session.inspect
        expect(response).to render_template("index")
      end
      it "there is a user" do
        get :index
        expect(User.count).to eq 1
      end
      # it "there is a  current user named 'meow'" do
      #   get :index
      #   expect(current_bro.name).to eq "meow"
      # end
    end
  end

  describe  "#user_search" do
    it 'includes bookis when twitter is searched for "booki"' do
      puts "******" + User.all.inspect
      request.session[:bro_id] = User.last.id
      puts "******" + session[:bro_id].inspect
      params = {search: "booki", provider: "twitter"}
      get :user_search, {}, params
      puts "******" + response.body.inspect
    end
  end
end
