Rails.application.routes.draw do
  root to: 'note#index'
  resources :note
end
