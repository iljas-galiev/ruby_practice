class Mutations::UpdateCard < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: true

  field :card, Types::CardType, null: true
  field :errors, [String], null: true

  def resolve(id:, name:)
    if context[:current_user].nil?
      return {
        card: nil,
        errors: ['Auth is needed']
      }
    end

    card = Card.find_by(id: id, user_id: context[:current_user].id)

    if card.nil?
      return {
        card: nil,
        errors: ['not found']
      }
    end

    if card.update_attributes(name: name)
      {
        card: card,
        errors: [],
      }
    else
      {
        card: nil,
        errors: card.errors.full_messages
      }
    end
  end
end


