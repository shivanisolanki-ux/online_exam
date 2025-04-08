Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get 'students/profile', to: 'students#profile'
  put 'students/change_password', to: 'students#change_password'
  

  # Subjects & Questions (Admin Only)
  resources :subjects, only: [:index, :create]
  resources :questions, only: [:index, :create]
  get '/admin/register', to: 'registrations#new', as: 'new_admin_registration'
  post '/admin/register', to: 'registrations#create', as: 'admin_registrations'

  # Exams & Ranking
  resources :exams, only: [:index, :create]
  get 'exams/rank', to: 'exams#rank'

  root "registrations#new"
  get "/register", to: "registrations#new"
  post "/register", to: "registrations#create", as: "registrations"
  # Meetings & Notices
  resources :meetings, only: [:index, :create]
  resources :notices, only: [:index, :create]

  # Root Path
  # root 'home#index'

  namespace :admin do
    resources :exams do
      post :attempt, on: :member
    end
  end
  
end
