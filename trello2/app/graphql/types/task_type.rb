module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :title, String, null: true
    field :description, String, null: true
    field :card_id, Integer, null: true
    field :created_at, Integer, null: true
    field :checked, Integer, null: true
  end
end
