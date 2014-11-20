class UsersController < ApplicationController

  def show
    @subscriptions =
    current_bro.subscriptions.collect do |subs|
      case subs.provider
      when "twitter"
        twitter_user = $client.user(subs.uid.to_i)
        { pic: twitter_user.profile_image_url.to_s, username: twitter_user.username }
      when "vimeo"
        vimeo_user = Vimeo::Simple::User.info(subs.uid)
        { pic: vimeo_user["portrait_medium"], username: vimeo_user["profile_url"].gsub("https://vimeo.com/", "") }
      end
    end
  end

  def update
    current_bro.update(params.require(:user).permit(:name, :email))
    redirect_to show_path
  end

end
