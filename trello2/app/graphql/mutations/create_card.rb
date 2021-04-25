class Mutations::CreateCard < Mutations::BaseMutation
  argument :name, String, required: true

  field :card, Types::CardType, null: true
  field :errors, [String], null: true

  def resolve(name: )

    if context[:current_user].nil?
      return {
        user: nil,
        errors: ['Auth is needed']
      }
    end

    card = Card.new(name: name, user_id: context[:current_user].id)
    if card.save
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

