Rails.application.routes.draw do

  root :to => redirect('/movies')

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users
  resources :user_sessions

  # get 'user_sessions/new'
  # get 'user_sessions/create'
  # get 'user_sessions/destroy'

  #get 'movies' => 'movie#index', :as => :movies
  
  resources :movies
  resources :jobs

  #get 'jobs' => 'job#index'
  #get 'job/:action' => 'job'

  resources :password_resets


  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resources :movies
      get 'auth' => 'users#api_auth'
    end
  end
end
