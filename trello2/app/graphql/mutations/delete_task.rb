class Mutations::DeleteTask < Mutations::BaseMutation
  argument :id, Int, required: true

  field :errors, [String], null: true

  def resolve(id: )

    if context[:current_user].nil?
      return {
        errors: ['Auth is needed']
      }
    end

    task = Task.find_by(id: id, user_id: context[:current_user].id)

    if task.nil?
      return {
        errors: ['not found']
      }
    end

    if task.destroy
      {
        errors: [],
      }
    else
      {
        errors: task.errors.full_messages
      }
    end
  end
end



