require 'pry'
class Hanoi

  attr_reader :towers

  def initialize
    @towers = [
        [3, 2, 1],
        [],
        []
      ]
  end

  def move(start_tower, end_tower)
    # binding.pry
    start_tower = @towers[start_tower - 1]
    end_tower = @towers[end_tower - 1]
    raise "Illegal Move" if start_tower.empty?

    if end_tower.empty?
      end_tower << start_tower.pop
    else
      start_disc = start_tower.last
      end_disc = end_tower.last
      if start_disc > end_disc
        raise "Illegal Move"
      else
        end_tower << start_tower.pop
      end
    end

  end

  def render
    tower_heights = {}
    @towers.each_with_index do |tower, idx|
      tower_heights[idx + 1] = tower.length
    end
    max_height = tower_heights.values.max

    string_render_array = Array.new(max_height) {''}

    towers_filler = @towers.map do |tower|
      until tower.length == max_height
        tower << nil
      end
      tower
    end
    switchup = towers_filler.my_transpose
    switchup.each_with_index do |row, row_idx|
      row.each_with_index do |disc|
        if !disc.nil?
          string_render_array[row_idx] += "#{disc} "
        elsif row_idx == 0
          string_render_array[row_idx] += "_ "
        else
          string_render_array[row_idx] += "  "
        end
      end
    end

    string_render_array = string_render_array.map do |row|
      row.strip
    end
    string_render_array.reverse.join("\n")

  end

  def won?
    return true if
      @towers.reject { |tower| tower.empty? }.size == 1 && @towers[0].empty?
    false
  end


end

class Array
  def my_transpose
    transposition = Array.new(self[0].size) { [] }
    self.each_with_index do |row, row_indx|
      self[row_indx].each_with_index do |el, col_indx|
        transposition[col_indx][row_indx] = el
      end
    end
    transposition
  end
end
