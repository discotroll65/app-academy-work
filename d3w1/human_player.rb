class HumanPlayer
  attr_accessor :letter_guess
  attr_reader :num_letters, :displayable_secret_word

  def initialize
    @displayable_secret_word = nil
    @num_letters = nil
    @letter_guess = nil
  end

  def pick_secret_word
    puts "Pick a secret word and enter the number of letters"
    @num_letters = Integer(gets)
    @displayable_secret_word = Array.new(num_letters) { "_" }
  end

  def guess
    puts "Enter a letter to guess"
    self.letter_guess = gets.strip
  end

  def check_guess(letter)
    puts "Your opponent guesses #{letter}"
    puts "Is there a '#{letter}' in your word?"
    print "y/n >> "
    answer = gets.strip
    if answer.upcase == "Y"
      p displayable_secret_word
      puts "\n\nEnter the position numbers (1 through #{@num_letters})"
      print "of the occurences of that letter, seperated by a space >> "
      letter_positions = gets.strip.split(" ")
      handle_guess_response(letter_positions, letter)
    else
      puts "\n\nGuesser must guess again!!"
    end
  end

  def handle_guess_response(letter_positions, letter)
    letter_indices = letter_positions.map { |position| position.to_i - 1}
    letter_indices.each do |index|
      self.displayable_secret_word[index] = letter
    end
  end

  def receive_secret_length(length_of_word_to_guess)
    @num_letters = length_of_word_to_guess
  end

end
