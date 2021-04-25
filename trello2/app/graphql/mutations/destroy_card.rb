class Mutations::DestroyCard < Mutations::BaseMutation
  argument :id, ID, required: true

  field :res, Boolean, null: true
  field :errors, [String], null: true

  def resolve(id:)

    if context[:current_user].nil?
      return {
        res: false,
        errors: ['Auth is needed']
      }
    end

    card = Card.find_by(id: id, user_id: context[:current_user].id)

    if card.nil?
      return {
        res: false,
        errors: ['not found']
      }
    end

    if card.destroy
      {
        res: true,
        errors: [],
      }
    else
      {
        res: false ,
        errors: card.errors.full_messages
      }
    end
  end
end



