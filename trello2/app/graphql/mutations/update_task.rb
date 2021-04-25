class Mutations::UpdateTask < Mutations::BaseMutation
  argument :id, Int, required: true
  argument :title, String, required: true
  argument :description, String, required: true

  field :task, Types::TaskType, null: true
  field :errors, [String], null: true

  def resolve(id:, title:, description:)
    if context[:current_user].nil?
      return {
        task: nil,
        errors: ['Auth is needed']
      }
    end

    task = Task.find_by(id: id, user_id: context[:current_user].id)

    if task.nil?
      return {
        task: nil,
        errors: ['not found']
      }
    end

    if task.update(title: title, description: description)
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



