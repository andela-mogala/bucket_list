module Authentication
  def sign_in(user)
    request.headers['Authorization'] = 'Bearer ' + user.auth_token
  end
end