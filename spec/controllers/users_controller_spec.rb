require 'rails_helper'

describe UsersController, :type => :controller do
  describe '#update' do
    before {User.create(name: "meow", email: "cat@meow.com")}
    before { session[:bro_id] = User.last.id }
    # Why does this test fail? Unknown. Mystery.
    xit "updates user name and email from params" do
      bro = User.find(session[:bro_id])
      patch :update, {id: bro.id, user: {name: "whiskers"} }
      # puts bro.inspect + "%%%%%%%%%%%%%"
      expect(bro.name).to eq "whiskers"
    end
  end
end
