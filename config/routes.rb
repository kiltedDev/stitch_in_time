Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
   }
  root   'static_pages#home'
  get    '/help',  to: 'static_pages#help'
  get    '/about', to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/change_password', to: 'devise/registrations#edit'

  devise_scope :user do
    get    '/login',   to: 'devise/sessions#new'
    post   '/login',   to: 'devise/sessions#create'
    delete '/logout',  to: 'devise/sessions#destroy'
  end
  resources :users, only: [:show, :index, :edit, :update]
  resources :projects
  resources :punches
  post 'punch_out', to: 'punches#punch_out', as: :punch_out

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
