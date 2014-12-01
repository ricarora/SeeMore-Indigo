class ProviderSearch

  def self.search_for(srch, provider)
    case provider
    when "Twitter"
      get_twitter_results(srch)
    when "Vimeo"
      get_vimeo_results(srch)
    when "Instagram"
      get_instagram_results(srch)
    end
  end


  def self.get_twitter_results(srch)
    @results = $client.user_search(srch).first(10)
  end

  def self.get_vimeo_results(srch)
    @results = Beemo::User.search(srch)
  end

  def self.get_instagram_results(srch)
    insta_client = Instagram.client(:access_token => session[:access_token])
    @results = insta_client.user_search(srch)
  end

end
