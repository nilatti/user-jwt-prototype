Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  resources :users, only: [:show]
  resources :sessions, only: [:create, :destroy]
end
