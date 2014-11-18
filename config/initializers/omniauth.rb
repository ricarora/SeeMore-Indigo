Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:username, :email],
    :uid_field => :email
end
