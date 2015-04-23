class Game
  attr_reader :guessing_player, :checking_player, :guessed_letters
  attr_accessor :displayable_secret_word

  def initialize (guessing_player, checking_player)
    @guess_limit = 6
    @displayable_secret_word = checking_player.pick_secret_word
    @guessing_player = guessing_player
    @checking_player = checking_player
    @guesses = 0
    @wrong_letters = []
  end

  def play
    greet
    while @guesses < @guess_limit
      display_progress
      give_feedback
      spend_move unless correct_guess?
      if player_won?
        return win_message
      end
    end
    puts "\n\n"
    display_progress
    puts "Sorry! you lose bro, out of guesses."
  end

  def display_progress
    word_progress
    letter_rejects
  end

  def letter_rejects
    puts "\nWrong letters: "
    puts "#{@wrong_letters.inspect}\n\n\n\n"
  end

  def word_progress
    p displayable_secret_word.join('')
  end

  def give_feedback
    puts "You have #{@guess_limit - @guesses} guesses left"
  end

  def correct_guess?
    word_before = displayable_secret_word.dup
    letter = guessing_player.guess
    checking_player.check_guess(letter)
    self.displayable_secret_word = checking_player.displayable_secret_word
    correct = (word_before != displayable_secret_word)
    @wrong_letters << letter unless correct
    correct
  end

  def spend_move
    @guesses += 1
  end

  def player_won?
    displayable_secret_word.each do |letter|
      return false if letter == "_"
    end
    true
  end

  def win_message
    puts "\n\n\nGuesser wins!"
    word_progress
  end

  def greet
    puts "Welcome to Hangman! Time to play!"
  end
end
