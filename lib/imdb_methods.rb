require 'yaml'
require 'sqlite3'
require 'awesome_print'
require 'date'

def get_imdb_film_data
  imdb = Imdb.new
  db = SQLite3::Database.new("data.db")

  #db.transaction
  # this is probably a bad idea
  movies = db.execute("select id,imdb_id from movies where imdb_id is not null;")
  actors = db.execute("select * from actors;")
  actors = Hash[actors]
  #movie_actors = db.execute("select * from movie_actors;")
  #movie_actors = Hash[movie_actors]
  genres = db.execute("select * from genres;")
  genres = Hash[genres]
  #movie_genres = db.execute("select * from movie_genres;")
  #movie_genres = Hash[movie_genres]
  directors = db.execute("select * from directors;")
  directors = Hash[directors]
  #movie_directors = db.execute("select * from movie_directors;")
  #movie_directors = Hash[movie_directors]
  writers = db.execute("select * from writers;")
  writers = Hash[writers]
  #movie_writers = db.execute("select * from movie_writers;")
  #movie_writers = Hash[movie_writers]
  # yep, there's shit loads of data held in memory, we should probably check for actors, genres etc, as and when
  #db.commit
  
  db.transaction
  total_movies = movies.count
  i = 1
  start = Time.now
  movies.each do |movie|
    print "[#{sprintf('%5.5s',i)}/#{total_movies}] "
    movie_id = movie[0]
    imdb_id = movie[1]
    response = imdb.get_with_id(imdb_id)
    result = JSON.parse(response)
    now = Time.now.to_s
    print "#{sprintf('%-100.100s',result["Title"])} "
    #ap result

    movie_title = result["Title"]
    movie_year = result["Year"]
    movie_rated = result["Rated"]
    movie_released = result["Released"]
    movie_runtime = result["Runtime"]
    movie_country = result["Country"]
    movie_awards = result["Awards"]
    movie_metascore = result["Metascore"]
    movie_imdb_rating = result["imdbRating"]
    movie_imdb_votes = result["imdbVotes"]
    movie_tomato_meter = result["tomatoMeter"]
    movie_tomato_rating = result["tomatoRating"]
    movie_tomato_consensus = result["tomatoConsensus"]

    db.execute( "update movies set title=?, year=?, rated=?, released=?, runtime=?,
                country=?, awards=?, metascore=?, imdb_rating=?, imdb_votes=?,
                tomato_meter=?, tomato_rating=?, tomato_consensus=?, updated=?
                where id=?;",
      [ movie_title,movie_year,movie_rated,movie_released,movie_runtime,
        movie_country,movie_awards,movie_metascore,movie_imdb_rating,movie_imdb_votes,
        movie_tomato_meter,movie_tomato_rating,movie_tomato_consensus,now,movie_id ])

    if !result["Actors"].nil?
      film_actors = result["Actors"].split(",")
      film_actors.each do |actor|
        actor.strip!
        if !actors.has_value?(actor)
          db.execute("insert into actors (actor) values(?);",actor)
          actor_id = db.execute("select id from actors where actor=?",actor)
          db.commit
          db.transaction
          actors[actor_id[0]] = actor
        end
      end
    end

    if !result["Genre"].nil?
      film_genres = result["Genre"].split(",")
      film_genres.each do |genre|
        genre.strip!
        if !genres.has_value?(genre)
          db.execute("insert into genres (genre) values(?);",genre)
          genre_id = db.execute("select id from genres where genre=?",genre)
          db.commit
          db.transaction
          genres[genre_id[0]] = genre
        end
      end
    end

    if !result["Writer"].nil?
      film_writers = result["Writer"].split(",")
      film_writers.each do |writer|
        writer.strip!
        if !writers.has_value?(writer)
          db.execute("insert into writers (writer) values(?);",writer)
          writer_id = db.execute("select id from writers where writer=?",writer)
          db.commit
          db.transaction
          writers[writer_id[0]] = writer
        end
      end
    end

    if !result["Director"].nil?
      film_directors = result["Director"].split(",")
      film_directors.each do |director|
        director.strip!
        if !directors.has_value?(director)
          db.execute("insert into directors (director) values(?);",director)
          director_id = db.execute("select id from directors where director=?",director)
          db.commit
          db.transaction
          directors[director_id[0]] = director
        end
      end
    end

    print "[ETA #{Time.now+((Time.now-start)*(total_movies/i))}]\n"
    i += 1
    #break
  end
  db.commit
end

def get_imdb_links
  imdb = Imdb.new
  db = SQLite3::Database.new("data.db")
  movies = db.execute("select id,imdb_id from movies where imdb_id is not null;")
  actors = db.execute("select * from actors;")
  actors = Hash[actors]
  genres = db.execute("select * from genres;")
  genres = Hash[genres]
  directors = db.execute("select * from directors;")
  directors = Hash[directors]
  writers = db.execute("select * from writers;")
  writers = Hash[writers]

  total_movies = movies.count
  i = 1
  start = Time.now
  movies.each do |movie|
    entries = 0
    links = 0
    print "#{sprintf('%5.5s',i)}/#{total_movies} | "
    movie_id = movie[0]
    imdb_id = movie[1]
    response = imdb.get_with_id(imdb_id)
    result = JSON.parse(response)

    if !result["Actors"].nil?
      film_actors = result["Actors"].split(",")
      film_actors.each do |actor|
        actor.strip!
        if !actors.has_value?(actor)
          db.execute("insert into actors (actor) values(?);",actor)
          actor_id = db.execute("select id from actors where actor=?",actor)
          actors[actor_id[0]] = actor
          entries += 1
        else
          actor_id = actors.key(actor)
        end
        link_exists = db.execute("select count(*) from movie_actors where movie_id=? and actor_id=?;",[movie_id,actor_id])
        if link_exists[0][0] == 0
          db.execute("insert into movie_actors (movie_id,actor_id) values(?,?);",[movie_id,actor_id])
          links += 1
        end
      end
    end

    if !result["Genre"].nil?
      film_genres = result["Genre"].split(",")
      film_genres.each do |genre|
        genre.strip!
        if !genres.has_value?(genre)
          db.execute("insert into genres (genre) values(?);",genre)
          genre_id = db.execute("select id from genres where genre=?",genre)
          genres[genre_id[0]] = genre
          entries += 1
        else
          genre_id = genres.key(genre)
        end
        link_exists = db.execute("select count(*) from movie_genres where movie_id=? and genre_id=?;",[movie_id,genre_id])
        if link_exists[0][0] == 0
          db.execute("insert into movie_genres (movie_id,genre_id) values(?,?);",[movie_id,genre_id])
          links += 1
        end
      end
    end

    if !result["Director"].nil?
      film_directors = result["Director"].split(",")
      film_directors.each do |director|
        director.strip!
        if !directors.has_value?(director)
          db.execute("insert into directors (director) values(?);",director)
          director_id = db.execute("select id from directors where director=?",director)
          directors[director_id[0]] = director
          entries += 1
        else
          director_id = directors.key(director)
        end
        link_exists = db.execute("select count(*) from movie_directors where movie_id=? and director_id=?;",[movie_id,director_id])
        if link_exists[0][0] == 0
          db.execute("insert into movie_directors (movie_id,director_id) values(?,?);",[movie_id,director_id])
          links += 1
        end
      end
    end

    if !result["Writer"].nil?
      film_writers = result["Writer"].split(",")
      film_writers.each do |writer|
        writer.strip!
        if !writers.has_value?(writer)
          db.execute("insert into writers (writer) values(?);",writer)
          writer_id = db.execute("select id from writers where writer=?",writer)
          writers[writer_id[0]] = writer
          writers += 1
        else
          writer_id = writers.key(writer)
        end
        link_exists = db.execute("select count(*) from movie_writers where movie_id=? and writer_id=?;",[movie_id,writer_id])
        if link_exists[0][0] == 0
          db.execute("insert into movie_writers (movie_id,writer_id) values(?,?);",[movie_id,writer_id])
          links += 1
        end
      end
    end

    print "#{sprintf('%-50.50s',result["Title"])} |"
    print "#{sprintf('%-3.3s',entries)} entries created |"
    print "#{sprintf('%-3.3s',links)} links created "

    print "| ETA #{Time.now+((Time.now-start)*(total_movies/i))}\n"
    i += 1
    #sleep(1)
    #break
  end
end