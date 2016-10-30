class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done
  attribute :created_at, key: :date_created
  attribute :updated_at, key: :date_updated
end
