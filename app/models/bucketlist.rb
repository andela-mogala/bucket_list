class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true,
                   length: { minimum: 2 }
  scope :filter_by_name, ->(keyword) do
    where('lower(name) LIKE ?', "%#{keyword.downcase}%")
  end
  scope :recently_added, -> { order(:created_at) }

  def self.search(params = {})
    return Bucketlist.all unless params[:name].present?
    Bucketlist.filter_by_name(params[:name]).recently_added
  end
end
