Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: :index
  end

  resources :contacts, only: [:create, :destroy, :show, :update]

  resources :contact_shares, only: [:create, :destroy]

#   get "/users", to: "users#index", as: "users"
#   post "/users", to: "users#create"
#   get "/users/new", to: "users#new", as: "new_user"
#   get "/users/:id", to: "users#show", as: "user"
#   get "/users/:id/edit", to: "users#edit", as: "edit_user"
#   patch "/users/:id", to: "users#update"
#   put "/users/:id", to: "users#update"
#   delete "/users/:id", to: "users#destroy"
end
