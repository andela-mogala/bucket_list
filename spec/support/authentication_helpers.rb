module Authentication
  def sign_in(user)
    request.headers['Authorization'] = 'Bearer ' + get_token(user).to_s
  end

  def get_token(user)
    token = JsonWebToken.encode({user_id: user.id,
                                 issued_at: Time.now,
                                 expires_at: 2.hours.from_now})
  end
end