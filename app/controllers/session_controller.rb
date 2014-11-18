class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    login = Authentication.where(uid: request.env["omniauth.auth"][:uid], provider: request.env["omniauth.auth"][:provider])
    if login.empty?
      # If empty, create a new Authentication/User
      # Authenication.request.env["omniauth.auth"][:uid]
    else
      session[:bro_id] = login.first.user.id
      User.create
    end

  end

end
