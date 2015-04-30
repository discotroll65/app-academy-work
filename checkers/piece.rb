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

  def on_board?(test_pos)
    row, col = test_pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def open_slides
    row, col = self.pos
    co_ords = move_diffs.map do |diff|
      diff_row, diff_col = diff
      [row + diff_row, col + diff_col] 
    end

    co_ords.select{|co_ord| on_board?(co_ord) && board[co_ord].nil?}
  end

  def perform_slide(input_pos)
    return false unless valid_slide?(input_pos)
    board[@pos] = nil
    board[input_pos] = self
    @pos = input_pos 
    true
  end

  def valid_slide?(test_pos)
    open_slides.include?(test_pos)
  end

end
