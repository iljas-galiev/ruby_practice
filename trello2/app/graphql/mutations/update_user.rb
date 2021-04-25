class Mutations::UpdateUser < Mutations::BaseMutation
  argument :id, Int, required: true
  argument :name, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve(id:, name:)

    if context[:current_user].nil?
      return {
        user: nil,
        errors: ['Auth is needed']
      }
    end

    user = User.find_by(id: id, user_id: context[:current_user].id)

    if user.nil?
      return {
        user: nil,
        errors: ['not found']
      }
    end

    if user.update_attributes(name: name)
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

