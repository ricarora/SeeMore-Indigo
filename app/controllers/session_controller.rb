class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create

    # request.env["omniauth.auth"]
    raise
  end
end
