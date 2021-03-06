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

  def obliterated?(dead_color)
    remaining_color = (dead_color == :white) ? :red : :white
    grid.all? do |row|
      row.all? do |piece|
        piece.nil? || piece.color == remaining_color
      end
    end
  end

  def no_more_moves?(stuck_color)
    grid.all? do |row|
      row.all? do |piece|
        if !piece.nil? && piece.color == stuck_color
          piece.open_slides.empty? && piece.open_jumps.empty?
        else
          true
        end
      end
    end
  end

  def all_jump_moves(color)
    all_pieces_of_color = []
      
    grid.each do |row|
      row.each do |piece|
        if !piece.nil? && piece.color == color
          all_pieces_of_color << piece
        end
      end
    end

    all_jump_moves = all_pieces_of_color.inject([]) do |memo, piece|
      piece.open_jumps.each do |jump|
        memo << jump
      end
      memo
    end

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
    numbers = (1..8).to_a.reverse
    board_display_array.each_with_index{|row, indx | puts "#{numbers[indx]} " +  row}
    puts "   a  b  c  d  e  f  g  h"
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
