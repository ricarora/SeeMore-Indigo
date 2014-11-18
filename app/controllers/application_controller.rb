class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  protect_from_forgery with: :exception

  private

  def current_bro
    @current_bro ||= User.find_by(id: session[:bro_id])
  end
  helper_method :current_bro

end
