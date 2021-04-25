module Types
  class MutationType < Types::BaseObject
    field :login_user, mutation: Mutations::LoginUser
    field :create_user, mutation: Mutations::CreateUser
    field :edit_user, mutation: Mutations::UpdateUser

    field :create_card, mutation: Mutations::CreateCard
    field :edit_card, mutation: Mutations::UpdateCard
    field :delete_card, mutation: Mutations::DestroyCard

    field :create_task, mutation: Mutations::CreateTask
    field :edit_task, mutation: Mutations::UpdateTask
    field :delete_task, mutation: Mutations::DestroyTask
    field :check_task, mutation: Mutations::CheckTask

  end
end
