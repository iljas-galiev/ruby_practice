class Mutations::CreateUser < Mutations::BaseMutation
  include AuthHelper
  argument :name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve(name:, email:, password:, password_confirmation:)

    unless context[:current_user].nil?
      return {
        user: nil,
        errors: ['Уже авторизован']
      }
    end

    user = User.new(name: name, email: email, password: password, password_confirmation: password_confirmation)
    if user.save
      context[:session][:user_id] = user.id
      {
        user: user,
        errors: [],
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
