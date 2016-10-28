Rails.application.routes.draw do
  root to: 'note#index'
  resources :note
  
  get 'add_children/:id', to: 'note#add_children', as: 'add_children'
  get 'add_sibling/:id', to: 'note#add_sibling', as: 'add_sibling'
  get 'toggle_complete/:id', to: 'note#toggle_complete', as: 'toggle_complete'
  get 'reload_tag_list', to: 'note#reload_tag_list', as: 'reload_tag_list'

  
end
