class ImdbGetAllJob
  #require "#{Rails.root}/config/environment"
  require "#{Rails.root}/lib/api_connection_classes"

  def perform
    Rails.logger.info "running GetAllImdbDataJob"
    imdb = Imdb.new
    movies = Movie.select(:id,:imdb_id,:title)
    movies.find_each do |movie|
      Rails.logger.info "imdb_get: #{movie.id} #{movie.imdb_id} #{movie.title}"
      response = imdb.get_with_id(movie.imdb_id)
      imdb_raw_movie = ImdbRawMovie.find_or_initialize_by(imdbID: movie.imdb_id) 
      imdb_raw_movie.from_json(response)
      imdb_raw_movie.save
    end
  end
end