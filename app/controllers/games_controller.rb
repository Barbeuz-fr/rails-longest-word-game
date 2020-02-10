require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # All lowercase letters.
    letters = "abcdefghijklmnopqrstuvwxyz"
    # Empty Array for letters we add.
    word = Array[]
    # Add all random letters.
    length = 1 + rand(10)
    length.times do
      # Get random index within string.
      r = rand 0..25
      # Get letter for index.
      letter = letters[r]
      # Push to our array.
      word.push(letter)
    end
    # instance variable for the word
    @letters = word

    # The form will be submitted (with POST) to the score action.
  end

  def score
    # recuperation de la reponse utilisateur
    @answer = params[:answer]
    @word_array = params[:letters]

    # Appel API avec @answer sur wagon-dictionary.herokuapp.com/
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    word_serialized = open(url).read
    # stockage reponse dans une variable d'instance @api-answer
    @api_answer = JSON.parse(word_serialized)
    @test_inclusion = @answer.chars.all? { |item| @word_array.chars.include?(item) }
  end
end
