Rails.application.routes.draw do

  root :to => redirect('/movies')

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users

  # get 'user_sessions/new'
  # get 'user_sessions/create'
  # get 'user_sessions/destroy'

  get 'movies' => 'movie#index', :as => :movies
  get 'jobs' => 'job#index'
  get 'job/:action' => 'job'
end
