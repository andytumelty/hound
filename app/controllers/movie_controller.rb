class MovieController < ApplicationController

  def index
    @actors = Actor.all
    @genres = Genre.all
    @directors = Director.all
    @writers = Writer.all

    @movies = Movie.where(nil)
    filtering_params(params).each do |key, value|
      @movies = @movies.public_send(key, value) if value.present?
    end
    limit = params[:limit] ||= 10
    @movies = @movies.order(metascore: :desc).first(limit)
  end

  private

  # def movie_params
  #   params.permit(:title, :year, :ms_gt, :ms_lt, :imdb_gt, :imdb_lt, :limit)
  # end

  def filtering_params(params)
    params.slice(:title, :year, :ms_gt, :ms_lt, :imdb_gt, :imdb_lt)
  end

end