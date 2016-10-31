class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :items
  attribute :created_at, key: :date_created
  attribute :updated_at, key: :date_updated
  attribute :user_id, key: :created_by
end
