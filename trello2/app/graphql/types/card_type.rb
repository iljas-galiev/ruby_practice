module Types
  class CardType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :user_id, Integer, null: true
    field :created_at, Integer, null: true
    field :tasks, [Types::TaskType], null: true
    field :created, String, null: true

    def created
      Time.at(object.created_at).to_s
    end
  end
end
