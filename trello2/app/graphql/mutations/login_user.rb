class Mutations::LoginUser < Mutations::BaseMutation
  include AuthHelper
  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve( email:, password:)

    unless context[:current_user].nil?
      return {
        user: nil,
        errors: ['Уже авторизован']
      }
    end

    user = User.find_by( email: email.downcase )
    if user && user.authenticate(password)
      context[:session][:user_id] = user.id
      {
        user: user,
        errors: [],
      }
    else
      {
        user: nil,
        errors: ['Неправильный E-mail или пароль']
      }
    end
  end
end
