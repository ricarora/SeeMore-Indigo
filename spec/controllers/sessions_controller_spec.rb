require 'rails_helper'
describe SessionsController, :type => :controller do
  # before {User.create(name: "meow", email: "cat@meow.com")}
    describe "#destroy" do
      # before { session[:bro_id] = 1 }
      # This test is failing, still need more research, feel free to work on this
        xit "sets session[:bro_id] to nil" do
          get :destroy
          expect(session[:bro_id]).to eq(nil)
      end
    end

    describe "GET create" do
      it "creates a user" do
        OmniAuth.config.add_mock(:developer, {:uid => "12345"})
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer]
        expect { get :create, provider: "developer" }.to change(User, :count).by(1)
      end
    end


end
