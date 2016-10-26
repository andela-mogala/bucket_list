class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :created_at, :updated_at
  attribute :created_at, key: :date_created
  attribute :updated_at, key: :date_updated
end
