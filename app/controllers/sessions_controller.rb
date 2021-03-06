class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  skip_before_filter :logged_in, only: :create

  #TODO: create a new user and authentication not in sessionContoller

  def create
    auth_hash = request.env["omniauth.auth"]
    login = Authentication.where(uid: auth_hash[:uid], provider: auth_hash[:provider])
    if current_bro
      if login.empty?
        current_bro.authentications.create(provider: auth_hash[:provider], uid: auth_hash[:uid])
        redirect_to show_path(current_bro.id), notice: "Authentication added"
      else
        redirect_to show_path(current_bro.id), notice: "Account already in use!"
      end
    else
      if login.empty?
        login << make_bro_and_auth(auth_hash)
        # If empty, create a new Authentication/User
      end
      session[:bro_id] = login.first.user.id
      redirect_to root_path, notice: "So stoked to see you, bro"
    end
  end

  def destroy
    #would reset session be better here?
    session[:bro_id] = nil
    redirect_to landing_page_path, notice: "Smell ya later, bro"
  end

  private

  def set_name_key(name_key)
    case name_key
    when "developer"
      :username
    when "instagram", "twitter", "github"
      :nickname
    end

  end

  def make_bro_and_auth(auth_hash)
    name = set_name_key( auth_hash[:provider] )
    new_bro = User.create(name: auth_hash[:info][name], email: auth_hash[:info][:email])
    new_bro.authentications.create(provider: auth_hash[:provider], uid: auth_hash[:uid])
  end


end
