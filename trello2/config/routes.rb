Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	resources :tasks
	resources :cards
  get '/tasks/:id/check', to: 'tasks#check',  as: "check_task"

  get 'signup'  => 'users#new'
  resources :users


  get    'login'   => 'auth#new'
  post   'login'   => 'auth#create'
  delete 'logout'  => 'auth#destroy'
  root to: "home#index"

end