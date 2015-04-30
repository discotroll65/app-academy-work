class Piece
  WHITE_DIFFS = [
    [-1, -1], [-1, 1]
  ]
  RED_DIFFS = [
    [1, -1], [1, 1]
  ]
  attr_reader :color, :king, :pos, :board
  attr_accessor :display

  def initialize(options)
    @color = options[:color]
    @king = false
    @pos = options[:pos]
    @display = 'P'
    @board = options[:board]
  end

  def display
    return "K" if king?
    "P"
  end

  def king?
    @king
  end

  def inspect
    {
      display: @display,
      king: @king,
      pos: @pos,
      color: @color
    }
  end

  def move_diffs
    if @king
      RED_DIFFS + WHITE_DIFFS
    else
      (@color == :white) ? WHITE_DIFFS : RED_DIFFS
    end
  end


  def perform_jump(end_pos)
    return false unless valid_jump?(end_pos)
    vector = [ (end_pos.first - @pos.first)/2, (end_pos.last - @pos.last)/2]
    victim_pos = [vector.first + @pos.first, vector.last + @pos.last]

    board.place_piece(self, victim_pos) #kill the dude
    @pos = victim_pos  
    
    board.place_piece(self, end_pos) #finish the jump
    @pos = end_pos 

    maybe_promote
    true
  end

  def perform_slide(end_pos)
    return false unless valid_slide?(end_pos)
    board.place_piece(self, end_pos)
    @pos = end_pos 
    maybe_promote
    true
  end

private

  def get_vector(hit_pos)
    [hit_pos.first - @pos.first, hit_pos.last - @pos.last]
  end

  def on_board?(test_pos)
    row, col = test_pos
    row.between?(0, 7) && col.between?(0, 7)
  end
  
  def open_jumps
    co_ords = slide_co_ords
    possible_hits = possible_hit_coords(slide_co_ords) 
    return [] if possible_hits.empty? 

    possible_lands = possible_landings(possible_hits)

    possible_lands.select do |landing_pos|
      on_board?(landing_pos) && board[landing_pos].nil?
    end
  end

  def open_slides
    co_ords = slide_co_ords 
    co_ords.select{|co_ord| on_board?(co_ord) && board[co_ord].nil? }
  end

  def possible_hit_coords(slide_co_ords)
    slide_co_ords.reject do |hit_pos|
      board[hit_pos].nil? || board[hit_pos].color == @color
    end
  end

  def possible_landings(possible_hit_coords)
     possible_hit_coords.map do |hit_pos|
      vector = get_vector(hit_pos)
      [hit_pos.first + vector.first, hit_pos.last + vector.last]
    end
  end

  def maybe_promote
    @king ||= true if at_last_row?
  end

  
  def at_last_row?
    current_row  = @pos.first
    last_row_indx =  (@color == :white ) ? 0 : 7
    last_row_indx == current_row ? true : false
  end

  def slide_co_ords
    row, col = self.pos
    co_ords = move_diffs.map do |diff|
      diff_row, diff_col = diff
      [row + diff_row, col + diff_col] 
    end
  end

  def valid_jump?(test_pos)
    open_jumps.include?(test_pos)
  end

  def valid_slide?(test_pos)
    open_slides.include?(test_pos)
  end

end