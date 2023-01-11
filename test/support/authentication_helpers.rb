module AuthenticationHelpers
  def log_in(user, password: "password")
    post login_path, params: {
           user: {
             email: user.email,
             password: password
           }
         }
  end

  def log_out
    delete logout_path
  end
end
