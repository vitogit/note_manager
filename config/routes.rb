Rails.application.routes.draw do
  root to: 'note#index'
  resources :note
  
  get 'add_children/:id', to: 'note#add_children', as: 'add_children'
  get 'toggle_complete/:id', to: 'note#toggle_complete', as: 'toggle_complete'

  
end
