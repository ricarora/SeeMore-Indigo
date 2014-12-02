# # Live coding with Bookis
# require "rails_helper"
#
# describe SessionsController do
#   describe 'GET create' do
#     it 'creates a user' do
#       # auth_hash = double("auth_hash")
#       # expect(request).to receive(:env).and_return({'omniauth.auth' => auth_hash})
#       OmniAuth.config.add_mock(:test, {:uid => '12345', credentials: {token: "1234"}})
#       request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:test]
#       expect { get :create, provider: "test" }.to change(User, :count).by(1)
#
#     end
#   end
# end
