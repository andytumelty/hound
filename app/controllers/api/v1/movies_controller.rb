class API::V1::MoviesController < ApplicationController
  before_filter :api_authenticate  

  def index
    render json: {message: "yay!"}
  end

  def show
  end
end