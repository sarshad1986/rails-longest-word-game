require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @attempt = params[:word]
    @attempt_array = @attempt.split("")
    # letters needs to be accessed in score method
    @letters = params[:letters].split(" ")
    @included = @attempt_array.all? {|letter| @attempt_array.count(letter) <= @letters.count(letter)}

    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    user_serialized = URI.open(url).read
    hash = JSON.parse(user_serialized)

    if @included == false && hash["found"] == true
      @result = "Word cannot be built from the grid"
    elsif @included == true && hash["found"] == false
      @result = "Word is not in the dictionary"
    elsif @included == true && hash["found"] == true
      @result = "Well done!"
    end
  end

end
