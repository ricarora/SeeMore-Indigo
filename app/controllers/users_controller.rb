class UsersController < ApplicationController

  def show
    @subscriptions = current_bro.subscriptions
  end

  def update
    current_bro.update(params.require(:user).permit(:name, :email))
    redirect_to show_path
  end

end
