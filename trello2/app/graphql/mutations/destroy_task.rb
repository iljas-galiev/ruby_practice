class Mutations::DestroyTask < Mutations::BaseMutation
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

    task = Task.find_by(id: id, user_id: context[:current_user].id)

    if task.nil?
      return {
        res: false,
        errors: ['not found']
      }
    end

    if task.destroy
      {
        res: true,
        errors: [],
      }
    else
      {
        res: false,
        errors: task.errors.full_messages
      }
    end
  end
end



