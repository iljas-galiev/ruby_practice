
class Mutations::CheckTask < Mutations::BaseMutation
  argument :id, Int, required: true

  field :task, Types::TaskType, null: true
  field :errors, [String], null: true

  def resolve(id:)

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

    task_params = { :checked => task.is_checked ? 0 : 1 }

    if task.update_attributes(task_params)
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



