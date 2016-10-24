class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true,
                   length: { minimum: 2 }
  scope :filter_by_name, ->(keyword) do
    where('lower(name) LIKE ?', "%#{keyword.downcase}%")
  end
end
