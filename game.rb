require_relative './board.rb'
require_relative './tile.rb'


class Game
  attr_reader :board, :over

  def initialize
    @board = Board.new
  end


  def play

    print_rules

    until self.over?
      board.display
      puts "Where would you like to go?"
      move = gets.chomp

      @board.use_move(move)
    end

  end

  def move_valid?(move)
    return false if ['r','f'].include?(move[0])
    return false if !move[1].between?(0,8)
    return false if !move[2].between?(0,8)
    true
  end


  def print_rules
  end



  def over?
  end


end


game = Game.new
game.play
