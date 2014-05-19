class ImdbGetPosters
  require "httparty"
  def perform
    movies = Movie.select(:id,:imdb_id,:title)
    movies.find_each do |movie|
      imdb_raw = ImdbRawMovie.select(:Poster).where(imdbID: movie.imdb_id).first
      if !imdb_raw.nil?
        poster_url = imdb_raw.Poster
        poster_path = "#{Rails.root}/public/images/movie_posters/#{movie.id}.jpg"
        if !poster_url.nil? && poster_url != 'N/A' && !File.exists?(poster_path)
          Rails.logger.info "imdb_poster_get: #{movie.id} #{movie.imdb_id} #{movie.title} #{poster_url}"
          File.open(poster_path, "wb") do |f| 
            f.write HTTParty.get("#{poster_url}").parsed_response
          end
        end
      end
    end
  end
end