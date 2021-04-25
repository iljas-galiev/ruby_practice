module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :password, String, null: true
    field :name, String, null: true
    field :status, Integer, null: true
    field :password_digest, String, null: true
    field :token, String, null: true
  end
end
