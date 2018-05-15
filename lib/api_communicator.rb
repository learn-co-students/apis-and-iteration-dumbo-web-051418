require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  character_hash = get_all_characters_hash

  hero = get_character_by_name(character_hash, character)
  # binding.pry
  films = hero.fetch("films", [])
  get_movies_hash(films)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def get_character_by_name(characters_hash, character_name)
  characters_hash["results"].find {|person| person["name"].downcase == character_name } || {}
end

def get_all_characters_hash
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def get_movies_hash(films)
  films_list = []
  films.each do |film|
    movie=RestClient.get(film)
    movie = JSON.parse(movie)
    films_list << movie
  end
  films_list
end

def parse_character_movies(films_list)
  # some iteration magic and puts out the movies in a nice list
  films_list.each_with_index do |film, index|
    puts "#{(index+1)} #{film['title']}"
  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
