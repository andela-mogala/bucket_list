class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true
  validates :password, length: { minimum: 8 },
                       confirmation: true

  has_many :bucketlists, dependent: :destroy
  has_one :auth, class_name: 'AuthenticationDatum'
end
