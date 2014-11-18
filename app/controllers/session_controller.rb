class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  #TODO: create a new user and authentication not in sessionContoller

  def create
    login = Authentication.where(uid: request.env["omniauth.auth"][:uid], provider: request.env["omniauth.auth"][:provider])
    if login.empty?
      User.create(name: request.env["omniauth.auth"][:first_name], email: request.env["omniauth.auth"][:last_name])
      login << User.authentications.create(provider: request.env["omniauth.auth"][:provider], uid: request.env["omniauth.auth"][:uid])
      # If empty, create a new Authentication/User
    end
    session[:bro_id] = login.first.user.id
    redirect_to root_path, notice: "Mi casa es tu casa, brah"
  end


end
