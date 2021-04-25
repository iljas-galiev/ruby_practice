module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: true do
      argument :id, ID, required: true
      argument :token, String, required: true
    end

    def user(id:, token:)
      User.find_by(id: id, token: token)
    end

    field :cards, [Types::CardType], null: false do
      argument :archived, Int, required: false
    end

    def cards(archived: 0)
      return [] if context[:current_user].nil?

      if archived > 0
        return Card.user(context[:current_user][:id]).archive.all
      end

      Card.user(context[:current_user][:id]).not_archive.all
    end

    field :card, Types::CardType, null: false do
      argument :id, ID, required: true
    end

    def card(id:)
      return [] if context[:current_user].nil?

      Card.find_by(id: id, user_id: context[:current_user][:id])
    end

    field :tasks, [Types::TaskType], null: false

    def tasks
      return [] if context[:current_user].nil?
      Task.user(context[:current_user][:id]).all
    end

    field :task, Types::TaskType, null: false do
      argument :id, ID, required: true
    end

    def task(id:)
      return [] if context[:current_user].nil?

      Task.find_by(id: id, user_id: context[:current_user][:id])
    end

  end
end
