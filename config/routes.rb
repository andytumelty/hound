Rails.application.routes.draw do
  root :to => redirect('/movies')
  get 'movies' => 'movie#index', :as => :movies
  get 'jobs' => 'job#index'
  get 'job/:action' => 'job'
end
