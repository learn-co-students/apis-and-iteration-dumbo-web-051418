require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  # Takes a SW's character, returns array of hashes of character's movies
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # Making a list of all the film URL's
  array = []
  character_hash["results"].each do |data|
    if data["name"] == character
      array << data['films']
    end
  end
  get_movie_data(array.flatten)
end


def get_movie_data(array)
  # Helper function: "get_character_movies_from_api"
  # Takes array of URL's, returns array of hashes for character argument
  data = array.collect do |link|
    all_info = RestClient.get(link)
    movie_hash = JSON.parse(all_info)
  end
  data
end


def parse_character_movies(films_array)
  # Enumerating through the array passed from 'get_character_movies_from_api', returning values of film title key
  films_array.collect do |film|
      film["title"]
    end
end


def show_character_movies(character)
  # Main function.  Returning movie titles of argument/character.
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

#Pry.start
