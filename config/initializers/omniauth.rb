Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:username, :email],
    :uid_field => :email
  provider :instagram,
    ENV["INSTAGRAM_CLIENT ID"],
    ENV["INSTAGRAM_CLIENT SECRET"]
end
