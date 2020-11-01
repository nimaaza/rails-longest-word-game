require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid_size = rand(5..15)
    letters = ('A'..'Z').to_a
    @letters = []
    grid_size.times { @letters << letters[rand(0...26)] }
  end

  def score
    @letters = params[:letters].split(',')
    word = params[:word].upcase
    @message = if !build_from_grid?(word)
                 "Sorry, but #{word} can't be built our of #{params[:letters]}..."
               elsif !english_word?(word)
                 "Sorry, but #{word} does not seem to be a valid English word..."
               else
                 "Congratulations, #{word} is a valid English word!"
               end
  end

  private

  def build_from_grid?(word)
    word.split('').all? { |letter| @letters.include?(letter) }
  end

  def english_word?(word)
    api_url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api_response = JSON.parse(open(api_url).read)
    api_response['found']
  end
end
