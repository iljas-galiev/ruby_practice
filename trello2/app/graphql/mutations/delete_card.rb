class Mutations::DeleteCard < Mutations::BaseMutation
  argument :id, Int, required: true

  field :errors, [String], null: true

  def resolve(id: )

    if context[:current_user].nil?
      return {
        errors: ['Auth is needed']
      }
    end

    card = Card.find_by(id: id, user_id: context[:current_user].id)

    if card.nil?
      return {
        errors: ['not found']
      }
    end

    if card.destroy
      {
        errors: [],
      }
    else
      {
        errors: card.errors.full_messages
      }
    end
  end
end



