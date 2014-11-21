Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:username, :email],
    :uid_field => :email
  provider :instagram,
    ENV["INSTAGRAM_CLIENT_ID"],
    ENV["INSTAGRAM_CLIENT_SECRET"]
  provider :twitter,
    ENV["TWITTER_CONSUMER_KEY"],
    ENV["TWITTER_CONSUMER_SECRET"]
    {
      :secure_image_url => 'true',
      :image_size => 'original',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
end
