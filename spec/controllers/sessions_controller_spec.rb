require 'rails_helper'
describe SessionsController do
  describe "#destroy" do
    before { session[:bro_id] = 1 }
    it "sets session[:bro_id] to nil" do
      get :destroy
      expect(session[:bro_id]).to eq(nil)
    end
  end
end
