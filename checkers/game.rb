require_relative 'board.rb'
require_relative 'human_player.rb'
require 'pry'

class Game

  attr_reader :board
  LETTER_MAPPING = {
    A: 0,
    B: 1,
    C: 2,
    D: 3,
    E: 4,
    F: 5,
    G: 6,
    H: 7
  }

  NUMBER_MAPPING = {
    8 => 0,
    7 => 1,
    6 => 2,
    5 => 3,
    4 => 4,
    3 => 5,
    2 => 6,
    1 => 7
  }



  def initialize( player1, player2)
    @red_player = player1
    @white_player = player2
    @turn = 1
    @board = Board.new
    @players = [0, player1, player2]
    @current_player = @players[@turn]

  end

  def play
    puts "Welcome to Checkers"
    
      binding.pry
    until over?
      begin
      board.show_board
      piece_input = @current_player.get_piece_input
      piece_pos = parse(piece_input).first
      piece = board[piece_pos]

      move_input = @current_player.get_move_input
      binding.pry if piece == board[[2,5]]
      moves = parse(move_input)
      piece.perform_moves(moves)

      rescue InvalidMoveError => e
       puts e.message
       retry
      end 

      @turn *= -1
      @current_player = @players[@turn]

    end
  end

  def over?
    return true if board.obliterated?(:white) || board.obliterated?(:red)
    return true if board.no_more_moves?(:white) || board.no_more_moves?(:red)
  end

  def parse(positions_array)
    positions_array.map do |pos_str|
      pos_str_arr = pos_str.split('')
      row = NUMBER_MAPPING[pos_str_arr.last.to_i] 
      col = LETTER_MAPPING[pos_str_arr.first.upcase.to_sym]
      [ row , col ]
    end
  end
end


if __FILE__ == $PROGRAM_NAME

  player1 = HumanPlayer.new(:red)
  player2 = HumanPlayer.new(:white)
  game = Game.new(player1, player2)

  game.play

end
