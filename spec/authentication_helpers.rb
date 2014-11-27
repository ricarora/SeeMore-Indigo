module AuthenticationHelpers
  def login(user)
    post login_path, :provider => "developer"
  end
end
