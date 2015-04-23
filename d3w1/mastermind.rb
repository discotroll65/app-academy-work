require 'byebug'

class Code
  attr_reader :sequence
  POSSIBILITIES = %w[R G B Y O P]

  def initialize (colors_array)
    @sequence = colors_array
  end

  def self.random
    random_pegs = []
    choices = (0..5).to_a
    4.times do |ind|
      random_pegs << POSSIBILITIES[choices.sample]
    end
    Code.new(random_pegs)
  end

  def self.parse(input_array)
    Code.new(input_array)
  end

  def exact_matches(cod_obj)
    number_exact_matches = 0
    own_sequence = @sequence
    comparing_sequence = cod_obj.sequence

    own_sequence.each_with_index do |el, index|
      if el == comparing_sequence[index]
        number_exact_matches += 1
      end
    end

    number_exact_matches
  end

  def near_matches(code_obj)
    color_overlap = @sequence & code_obj.sequence
    number_near_matches = color_overlap.count - exact_matches(code_obj)
  end
end

class Game

  def initialize
    @secret_code = Code.random
    @guesses = 0
    @guess_limit = 10
    @current_guess = nil
  end

  def play
    puts @secret_code.sequence
    greet
    puts "Enter your sequence in the following format:"
    puts "<R B G Y>   (this is an example)"
    while @guesses < @guess_limit
      get_move
      spend_move
      if player_won?
        return win_message
      end
      give_feedback
    end

    puts "Sorry! you lose bro, out of guesses."
  end

  def spend_move
    @guesses += 1
  end

  def player_won?
    @secret_code.sequence == @current_guess.sequence
  end

  def give_feedback
    num_exact_matches = @secret_code.exact_matches(@current_guess)
    num_near_matches = @secret_code.near_matches(@current_guess)
    puts "You got #{num_exact_matches} exact matches."
    puts "You got #{num_near_matches} near matches"
    puts "You have #{@guess_limit - @guesses} guesses left."
  end

  def win_message
    puts "Yay you won!"
  end

  def get_move
    print "Your input >> "
    input = gets.strip

    input_array = input.split(' ')
    @current_guess = Code.parse(input_array)
  end

  def greet
    puts "Welcome to MASTERMIND"
    puts "There is a bag of pegs, each of which could be"
    puts "one of the following colors:\n\n"
    puts "#{Code::POSSIBILITIES}"
    puts "I am going to pick four at random, and put them in order"
    puts "\n\nYou have #{@guess_limit} guesses to guess the order"
    puts "and color of the pegs!"
  end
end

game = Game.new
game.play
