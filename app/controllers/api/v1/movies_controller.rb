class API::V1::MoviesController < ApplicationController
  before_filter :api_authenticate  

  def index
    @movies = Movie.where(nil).limit(10)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end