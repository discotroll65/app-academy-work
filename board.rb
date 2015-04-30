require 'byebug'
require_relative './tile.rb'



class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    @over = false
    self.seed_tiles
    self.seed_bombs
  end


  def display
    @grid.each do |row|
      display_row = []

      row.each do |tile|
        display_row << tile.inspect
        if tile.inspect == 'B'
          @over = true
        end
      end

      p display_row
    end
  end

  def use_move(user_input)
    x = user_input[1].to_i
    y = user_input[2].to_i

    if user_input[0].upcase == 'F'
      @grid[x][y].flag_toggle
    else
      @grid[x][y].uncover(x, y)
    end

    puts "We are here"
  end

  def seed_tiles
    @grid.each_with_index do |row, x|
      row.each_with_index do |col, y|
        @grid[x][y] = Tile.new(self, [x,y])
      end
    end
  end

  def seed_bombs
    bomb_coords = []
    until bomb_coords.count == 10
      x_coord = rand(0..8)
      y_coord = rand(0..8)
      bomb_coords << [ x_coord, y_coord ]
      bomb_coords = bomb_coords.uniq
    end

    bomb_coords.each do |(x, y)|
      @grid[x][y].bomb = true
    end
  end

end
