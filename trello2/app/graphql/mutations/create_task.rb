class Mutations::CreateTask < Mutations::BaseMutation
  argument :title, String, required: true
  argument :description, String, required: true
  argument :card_id, Int, required: true

  field :task, Types::TaskType, null: true
  field :errors, [String], null: true

  def resolve(title:, description:, card_id:)

    if context[:current_user].nil?
      return {
        user: nil,
        errors: ['Auth is needed']
      }
    end

    task = Task.new(title: title, description: description, card_id: card_id, user_id: context[:current_user].id)
    if task.save
      {
        task: task,
        errors: [],
      }
    else
      {
        task: nil,
        errors: task.errors.full_messages
      }
    end
  end
end


