class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  skip_before_filter :logged_in, only: :create

  #TODO: create a new user and authentication not in sessionContoller

  def create
    auth_hash = request.env["omniauth.auth"]
    login = Authentication.where(uid: auth_hash[:uid], provider: auth_hash[:provider])
    if login.empty?
      name = set_name_key( auth_hash[:provider] )
      new_bro = User.create(name: auth_hash[:info][name], email: auth_hash[:info][:email])
      login << new_bro.authentications.create(provider: auth_hash[:provider], uid: auth_hash[:uid])
      # If empty, create a new Authentication/User
    end
    session[:bro_id] = login.first.user.id
    redirect_to root_path, notice: "So stoked to see you, bro"
  end

  def destroy
    #would reset session be better here?
    session[:bro_id] = nil
    redirect_to landing_page_path, notice: "Smell ya later, bro"
  end

  def set_name_key(name_key)
    case name_key
    when "developer"
      :username
    when "instagram", "twitter"
      :nickname
    end

  end


end
