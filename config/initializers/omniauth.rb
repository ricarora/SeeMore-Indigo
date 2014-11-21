Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:username, :email],
    :uid_field => :email
  provider :instagram,
    ENV["INSTAGRAM_CLIENT_ID"],
    ENV["INSTAGRAM_CLIENT_SECRET"]
end
