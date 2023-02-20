require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
    letter = ('A'..'Z').to_a.sample
    @letters << letter
    end
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    word = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(word.read)
    json['found']
  end
end
