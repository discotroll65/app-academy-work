require_relative 'piece.rb'
require 'pry'
require 'colorize'
class Board
  attr_reader :grid

  def initialize(setup = true)
    @grid = Array.new(8) {Array.new(8) {nil} }
    @setup = setup
    setup_board if setup
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def dup
    duped_board = Board.new(false)
    grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        unless piece.nil?
          duped_board[[row_index, col_index]] = piece.dup(duped_board)
        end
      end
    end
    duped_board
  end

  def inspect
    self.show_board
  end

  def place_piece(piece, end_pos)
    self[piece.pos] = nil
    self[end_pos] = piece
  end

  def square_render(pos, back_color)
    if self[pos].nil?
      "   ".colorize(background: back_color)
    else
      piece = self[pos]
      " #{piece.display} ".colorize(background: back_color, color: piece.color)
    end
  end

  def show_board
    board_display_array = Array.new(8) {''}

    grid.each_with_index do |row, row_indx|
      row.each_index do |col_indx|
        if self.class.dark_square?( [row_indx, col_indx] )
          board_display_array[row_indx] += 
            square_render( [row_indx, col_indx], :grey )
        else
          board_display_array[row_indx] += 
            square_render( [row_indx, col_indx], :red )
        end
      end
    end
    system 'clear'
    board_display_array.each_with_index{|row, indx | puts "#{indx} " +  row}
    puts "   0  1  2  3  4  5  6  7"
    nil
  end
  
  private
  def place_starting_piece(color, pos)
    self[pos] = Piece.new(color: color, pos: pos,  board: self)
  end

  def setup_board
    self.grid.each_with_index do |row, row_indx|
      row.each_index do |col_indx|
        if row_indx < 3 && self.class.dark_square?([row_indx, col_indx])
          place_starting_piece(:red, [row_indx, col_indx] )
        elsif row_indx > 4 && self.class.dark_square?([row_indx, col_indx])

          place_starting_piece(:white, [row_indx, col_indx] )
        end
      end
    end
  end

  def self.dark_square?(pos)
    row, col = pos
    (row + col) % 2 != 0
  end


end
