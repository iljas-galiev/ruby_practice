Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	resources :tasks
	resources :cards

  get 'signup'  => 'users#new'
  resources :users


  get    'login'   => 'auth#new'
  post   'login'   => 'auth#create'
  delete 'logout'  => 'auth#destroy'
  root to: "home#index"
end
