class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true,
                   length: { minimum: 2 }
  scope :filter_by_name, ->(keyword) do
    where('lower(name) LIKE ?', "%#{keyword.downcase}%")
  end
  scope :recently_added, -> { order(:created_at) }
  scope :paginate, ->(page, limit = 20) do
    offset((page.to_i.abs - 1) * limit.to_i.abs)
      .limit(limit.to_i.abs)
  end

  def self.search(params = {})
    bucketlists = Bucketlist.filter_by_name(params[:q]) if params[:q].present?
    if params[:page].present? && params[:limit].present?
      bucketlists.paginate(params[:page], params[:limit])
    else
      bucketlists || Bucketlist.all
    end
  end
end
