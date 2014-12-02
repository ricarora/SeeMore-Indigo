# require "rails_helper"
#
# describe FeedController do
#   describe 'Get index' do
#     it 'is successful' do
#       user = User.create
#       Provider.create(service: "instagram", token: "1234", user_id: user.id)
#       session[:user_id] = user.id
#       instagram_object = double("Instagram", user_media_feed: [])
#       expect(Instagram).to receive(:client).and_return(instagram_object)
#
#       # The below two line are exactly the same - Rspec 3 & Rspec 2 syntax
#       # allow(Instagram).to receive(:client).and_return(instagram_object)
#       # Instagram.stub(:client) { instagram_object }
#
#       get :index
#       expect(response.status).to eq 200
#     end
#   end
# end
