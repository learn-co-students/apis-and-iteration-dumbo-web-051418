require 'rest-client'
require 'json'
require 'pry'

# iterate over the character hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_data = get_character(character, character_hash)
  if character_data == nil
    return nil
  end

  films = []
  character_data["films"].each do |film|
      data = RestClient.get(film)
      current_film = JSON.parse(data)
      films << current_film
    end
  films
end


def get_character(character, character_hash)
  character_hash["results"].each do |character_data|
    if character_data["name"].downcase == character
      return character_data
    end
  end
  puts "No character data"
  return nil
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  titles = Array.new
  films_hash.each do |film|
    titles.push(film["title"])
  end
  titles
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)

  if films_hash == nil
    return nil
  end

  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
