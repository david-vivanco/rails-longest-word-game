require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    vowels = [ "A", "E", "I", "O", "U" ]
    @letters = []
    # force to have at least 2 vowels
    @letters[0] = vowels.sample
    @letters[1] = vowels.sample
    i = 2
    # and fill the rest randomly
    8.times do
      @letters[i] = alphabet.sample
      i += 1
    end
    # resuffle the array so the vowels do not appear first
    @letters.shuffle!
  end
  def score
    @word = params[:word].to_s.upcase
    verificationArray = params[:letters].dup
    # Test 1: verify the @word can be built from the proposed letters
    @wordArray = @word.chars
    @flagTest1 = true
    @wordArray.each do |letter|
      if verificationArray.include?(letter)
         # remove from verificationArray, so we use each letter once
         verificationArray.delete_at(verificationArray.index(letter))
      else
        @flagTest1 = false
      end
    end
    # Test 2: check if the @word is in a dictionnary
    api_url = "https://dictionary.lewagon.com/#{@word}"
    api_outcome = JSON.parse(URI.parse(api_url).read)
    @flagTest2 = api_outcome["found"]
  end
end
