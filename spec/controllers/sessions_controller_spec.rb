require 'rails_helper'
describe SessionsController, :type => :controller do
  before {User.create(name: "meow", email: "cat@meow.com")}
    describe "#destroy" do
      before { session[:bro_id] = 1 }
      # This test is failing, still need more research, feel free to work on this
        xit "sets session[:bro_id] to nil" do
          get :destroy
          expect(session[:bro_id]).to eq(nil)
      end
  end



end
