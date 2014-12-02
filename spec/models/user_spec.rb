require 'rails_helper'

describe User do
  describe '#providers' do

    before { User.create.authentications << Authentication.create(provider: "twitter") }
    let(:bro) { User.find(User.last.id) }

    it "lists providers that user has authenticated with" do
      expect(bro.providers).to include("twitter")
    end

    it "returns an array equal to the number of user authentications" do
      expect(bro.providers.count).to eq 1
    end
    
  end
end
