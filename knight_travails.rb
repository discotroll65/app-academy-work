require "./00_tree_node.rb"
require 'byebug'

class KnightPathFinder

  def initialize(start_pos)
    @visited_positions = [start_pos]
    @move_tree = self.build_move_tree(start_pos)
  end

  def self.valid_moves(pos)
    valid_jumps = [ ]
    x , y = pos[0] , pos[1]
    all_position_offsets = [ [-2, 1], [-2, -1], [-1, 2], [2, 1], [2, -1],
                              [1, 2], [-1, -2], [1, -2] ]
    all_position_offsets.each do |offset|
      new_x, new_y =  x + offset[0] , y + offset[1]
      valid_jumps << [new_x, new_y] if self.in_bounds?( new_x , new_y )
    end


  end

  def self.in_bounds?( pos_x , pos_y )
    (0..8).include?(pos_x) && (0..8).include?(pos_y)
  end


  def build_move_tree(pos)

  end

  def new_move_positions(pos)
    #should add new positions that we haven't gotten to before to @visited_positions
    possible_moves = self.class.valid_moves - @visited_positions
    possible_moves.each { |move| @visited_positions << move }

    possible_moves
  end


end
