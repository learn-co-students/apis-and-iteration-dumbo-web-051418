require 'rest-client'
require 'json'
require 'pry'

def get_info_from_api
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

def get_character_movies_from_api(character)
  #make the web request
  character_films = nil
  get_info_from_api["results"].map do |element|
    char_name = element["name"]
    if char_name == character
      character_films = element["films"]
    end
  end
  character_films
end

def get_movie_info_from_api
  all_movies_for_character = RestClient.get('http://www.swapi.co/api/films/')
  parsed_movies = JSON.parse(all_movies_for_character)
end

def get_movies_info(movies_hash)
  movie_list = []
  movies_hash["results"].map do |element|
    movie_list << element
  end
  movie_list
end

#get_character_movies_from_api("Luke Skywalker")
get_movies_info(get_movie_info_from_api)

  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(movie_list)
  # some iteration magic and puts out the movies in a nice list

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
