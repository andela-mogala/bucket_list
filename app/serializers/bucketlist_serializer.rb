class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_many :items
end
