class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true,
                   length: { minimum: 2 }
  scope :filter_by_name, lambda { |keyword|
    where('lower(name) LIKE ?', "%#{keyword.downcase}%")
  }
  scope :recently_added, -> { order(:created_at) }
  scope :paginate, lambda { |page, limit = 20|
    offset((page.to_i.abs - 1) * limit.to_i.abs)
      .limit(limit.to_i.abs)
  }

  def self.search(params = {})
    bucketlists = Bucketlist.filter_by_name(params[:q]) if params[:q].present?
    bucketlists = Bucketlist.paginate(params[:page], params[:limit]) if
      params[:page].present? && params[:limit].present?
    bucketlists || Bucketlist.all
  end
end
