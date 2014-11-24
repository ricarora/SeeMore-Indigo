class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :logged_in
  helper :all
  protect_from_forgery with: :exception

  private

  # def insta_client
  #   insta_client ||= Instagram.client(:access_token => session[:access_token])
  # end

  def current_bro
    @current_bro ||= User.find_by(id: session[:bro_id])
  end
  helper_method :current_bro

  def logged_in
    if current_bro == nil
      redirect_to landing_page_path
    end
  end


end
