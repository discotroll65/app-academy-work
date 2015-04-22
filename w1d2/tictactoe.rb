# game has a board, two players,

# board has grid of cells
# board has a

# players make moves,
#players have either x or o
require 'byebug'
class Board
  attr_reader :grid
  attr_accessor :winner

  def initialize
    @grid = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]
    @winner = nil

  end

  def cell_value(input)
    coords = map_input_to_grid(input)
    x = coords[1]
    y = coords[0]
    grid[y][x]
  end

  def empty?(input)
    cell_value(input).is_a? Fixnum
  end

  def board_full?
    (1..9).each do |move|
      check = move.to_s
      return false if empty?(check)
    end
    true
  end

  def map_input_to_grid(input)
    map_hash = {
      '1' => [0, 0],
      '2' => [0, 1],
      '3' => [0, 2],
      '4' => [1, 0],
      '5' => [1, 1],
      '6' => [1, 2],
      '7' => [2, 0],
      '8' => [2, 1],
      '9' => [2, 2]
    }

    map_hash[input]
  end

  def display
    puts " #{cell_value('1')} | #{cell_value('2')} | #{cell_value('3')} "
    puts "---|---|---"
    puts " #{cell_value('4')} | #{cell_value('5')} | #{cell_value('6')} "
    puts "---|---|---"
    puts " #{cell_value('7')} | #{cell_value('8')} | #{cell_value('9')} "

  end

  def place_mark(input, mark)
    if empty?(input)
      y, x = map_input_to_grid(input)
      grid[y][x] = mark
      return true
    end

    false
  end

  def marker_won?(marker)
    test_case = Array.new(3){marker}
    check_rows(test_case) || check_columns(test_case) || check_diags(test_case)
  end

  def check_rows(test_case)
    grid.each do |row|
      return true if row == test_case
    end
    false
  end

  def check_columns(test_case)
    transposed = grid.transpose
    transposed.each do |row|
      return true if row == test_case
    end
    false
  end

  def check_diags(test_case)
    diag1 = [cell_value('1'), cell_value('5'), cell_value('9')]
    diag2 = [cell_value('7'), cell_value('5'), cell_value('3')]
    return true if diag1 == test_case || diag2 == test_case
    false
  end

  def anybody_win?
    result = false
    markers = ['X', 'O']
    markers.each do |marker|
      if marker_won?(marker)
        self.winner = marker
        result = true
      end
    end
    result
  end

  def end_status
    result = { status: "", winner: "" }
    if anybody_win?
      result[:status] = 'Win!'
      result[:winner] = winner
    else
      result[:status] = "Cat's game!"
      result[:winner] = "Nobody"
    end
    result
  end

end

class Game
  attr_accessor :player1, :player2, :turn_marker, :turn_counter
  attr_reader :board



  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_marker = 'X'
    @turn_counter = -1
    @board = Board.new
  end

  def play
    puts "Welcome to TicTacToe!"
    #choose_opponent
    display

    loop do
      make_move
      if game_over?
        win_condition
        break
      end
      change_turn
    end
  end

  def game_over?
    board.board_full? || board.anybody_win?
  end

  def make_move
    print "#{turn_marker}, please enter move >> "
    move = gets.strip
    move = sanitize_move(move)
    board.place_mark(move, turn_marker )
    display
  end

  def sanitize_move(move)
    while !move_valid?(move)
      puts "\n\nNot a valid move, or already taken!"
      display
      print "Please enter a move from 1 to 9 >>"
      move = gets.strip
    end
    move
  end

  def move_value(move)
    board.cell_value(move)
  end

  def move_valid?(move)
    in_range?(move) && cell_empty?(move)
  end

  def in_range?(move)
    move_as_num = move.to_i
    if (1..9).include?(move_as_num)
      return true
    end
    false
  end

  def cell_empty?(move)
    if in_range?(move)
      return true if move_value(move).is_a? Fixnum
    end
    false
  end

  def display
    board.display
  end

  def win_condition
    win_hash = board.end_status
    status = win_hash[:status]
    winner = win_hash[:winner]
    puts "\n\n********************\n\n"
    display
    if status == "Win!"
      puts "\n\nAlright #{winner}, nice #{status}!!!!!!"
    else
      puts "\n\n#{status} :(\n#{winner} wins."
    end
  end

  def change_turn
    self.turn_counter *= -1
    if turn_counter > 0
      self.turn_marker = 'O'
    else
      self.turn_marker = 'X'
    end
  end

end

class Player

  attr_reader :marker

  def initialize
  end

end

class HumanPlayer < Player

  def get_move
    print "Please enter your move >> "
    move = gets.strip
  end
end
