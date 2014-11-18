require 'twitter'

account = Settings['twitter']
$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = account["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = account["TWITTER_CONSUMER_SECRET"]
  config.access_token        = account["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = account["TWITTER_ACCESS_TOKEN_SECRET"]
end
