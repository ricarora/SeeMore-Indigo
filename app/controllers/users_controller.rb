class UsersController < ApplicationController

  def show
    @subscriptions =
    current_bro.subscriptions.collect do |subs|
      case subs.provider
      when "twitter"
        twitter_user = $client.user(subs.uid.to_i)
        { pic: twitter_user.profile_image_url.to_s,
          username: twitter_user.username,
          provider: "twitter",
          uid: subs.uid.to_s }
      when "vimeo"
        vimeo_user = Vimeo::Simple::User.info(subs.uid)
        { pic: vimeo_user["portrait_medium"],
          username: vimeo_user["profile_url"].gsub("https://vimeo.com/", ""),
          provider: "vimeo",
          uid: subs.uid.to_s }
      when "instagram"
        insta_client = Instagram.client(:access_token => session[:access_token])
        insta_user = insta_client.user(subs.uid)
        { pic: insta_user.profile_picture,
          username: insta_user.username ,
          provider: "instagram",
          uid: subs.uid.to_s }
      end
    end
  end

  def destroy
    sub_params = params[:subscription]
    subs = Subscription.where(uid: sub_params[:uid], provider: sub_params[:provider])[0]
    if current_bro.subscriptions.include? subs
      current_bro.subscriptions.destroy(subs.id)
    end
    redirect_to :back
  end

  def update
    current_bro.update(params.require(:user).permit(:name, :email))
    redirect_to show_path
  end

end
