class Tile
  attr_reader :board, :own_position
  attr_accessor :bomb, :flagged, :number_of_bombs

  OFFSETS = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
    [1,1],
    [-1,1],
    [1,-1],
    [-1,-1]
  ]

  def initialize(board_obj, own_position )
    @board = board_obj
    @flagged = false
    @bomb = false
    @display = '*'
    @reveal = false
    @number_of_bombs = 0
    @own_position = own_position
  end

  def bombed?
    @bomb
  end

  def flag_toggle
    @flagged = @flagged ? false : true
  end

  def inspect
    if !@reveal
      @flagged ? 'F' : '*'
    elsif bombed?
      'B'
    elsif bomb_count(@own_position[0], @own_position[1]) == 0
       '_'
    else
      "#{self.bomb_count(*@own_position)}"
    end
  end

  def reveal
    @reveal = true
  end

  def revealed?
    @reveal
  end

  def uncover(x, y)
    #need to fix this
    if bomb_count(x, y) == 0
      self.propogate
    elsif bombed?
      self.reveal
      puts "Game Over"
    else
      reveal
    end
  end

  def propogate
    @reveal = true

    neighbors.each do |(x, y)|
      if bomb_count(x, y) == 0 && !@board.grid[x][y].revealed?
        @board.grid[x][y].propogate
      else
         @board.grid[x][y].reveal
      end
    end
  end

  def bomb_count(x, y)
    counter = 0
    neighbors.each do |(x, y)|
      counter += 1 if @board.grid[x][y].bombed?
    end

    counter
  end

  def neighbors
    neighbors_array = []
    x = @own_position[0]
    y = @own_position[1]

    OFFSETS.each do |dx, dy|
      if on_board?(x + dx, y + dy)
        neighbors_array << [ (x + dx), (y + dy) ]
      end
    end

    neighbors_array
  end

  def on_board?(x, y)
    x.between?(0,8) && y.between?(0,8)
  end
end
