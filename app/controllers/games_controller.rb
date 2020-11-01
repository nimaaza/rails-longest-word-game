class GamesController < ApplicationController
  def new
    grid_size = rand(5..15)
    letters = ('A'..'Z').to_a
    @letters = []
    grid_size.times { @letters << letters[rand(0...26)] }
  end

  def score
    @letters = params[:letters].split(',')
  end
end
