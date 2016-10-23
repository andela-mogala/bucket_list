module Authentication
  def sign_in(user)
    request.headers['Authorization'] = 'Bearer ' + get_token(user).to_s
  end

  def get_token(user)
    token = JsonWebToken.encode({user_id: user.id})
  end
end