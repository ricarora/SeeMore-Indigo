class UsersController < ApplicationController

  def show
    @subscriptions = current_bro.subscriptions
    @added_providers = current_bro.providers
    @providers = ["twitter", "instagram", "github"]
  end

  def update
    current_bro.update(params.require(:user).permit(:name, :email))
    redirect_to show_path
  end

end
