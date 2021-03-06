require 'vimeo'
require 'beemo'

base = Vimeo::Advanced::Base.new(ENV["VIMEO_CLIENT_IDENTIFIER"], ENV["VIMEO_CLIENT_SECRET"])
request_token = base.get_request_token
SECRET = request_token.secret
$video = Vimeo::Advanced::Video.new(ENV["VIMEO_CLIENT_IDENTIFIER"], ENV["VIMEO_CLIENT_SECRET"], :token => ENV["VIMEO_ACCESS_TOKEN"], :secret => SECRET)
