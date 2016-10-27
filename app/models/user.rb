class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true
  validates :password, length: { minimum: 8 },
                       confirmation: true

  has_many :bucketlists, dependent: :destroy
  after_create :generate_token_and_update

  def generate_token_and_update
    update_attribute(:auth_token, generate_token!)
  end

  def token_expired?(current_token)
    current_token == auth_token &&
      (token_params[:issued_at].to_datetime -
        token_params[:expires_at].to_datetime) <= 0
  end

  private

  def token_params
    JsonWebToken.decode(auth_token)
  end

  def generate_token!
    self.auth_token = JsonWebToken.encode(user_id: id,
                                          issued_at: Time.now,
                                          expires_at: 2.hours.from_now)
  end
end
