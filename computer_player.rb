require 'set'
require 'byebug'

class ComputerPlayer
  attr_accessor :letter_guess
  attr_reader :num_letters, :displayable_secret_word, :dictionary,
              :letters_repo

  def initialize
    @dictionary = ComputerPlayer.get_dictionary
    @secret_word = @dictionary.sample.split("")
    @displayable_secret_word = Array.new(@secret_word.length) {'_'}
    @num_letters = @secret_word.length
    @letter_guess = nil
    @letters_repo = ("a".."z").to_a
  end

  def self.get_dictionary
    dirty_dictionary = File.readlines('dictionary.txt').to_set
    dirty_dictionary.map(&:chomp)
  end

  def pick_secret_word
    displayable_secret_word
  end

  def guess
    letters_repo.sample
    
  end

  def check_guess(letter)
    puts "Your guess is '#{letter}'"
    puts "Secret word is #{@secret_word.join}\n\n"
    if guess_correct?(letter)
      check_result_hash = get_correct_letter_indices(letter)
      handle_guess_response(check_result_hash, letter)

    else
      puts "\n\nGuesser must guess again!!"
    end
  end

  def handle_guess_response(check_result_hash, letter)
    letter_indices = check_result_hash[letter.to_sym]
    letter_indices.each do |index|
      self.displayable_secret_word[index] = letter
    end
  end

  def guess_correct?(letter)
    @secret_word.each_with_index do |known_letter, indx|
      if letter == known_letter
        return true
      end
    end
    false
  end

  def get_correct_letter_indices(letter)
    result = Hash.new {|h,k| h[k]=[]}
    @secret_word.each_with_index do |known_letter, indx|
      if letter == known_letter
        result[letter.to_sym] << indx
      end
    end
    result
  end

end
