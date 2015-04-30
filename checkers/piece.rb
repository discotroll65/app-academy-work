class Piece
  attr_reader :color, :king, :pos
  attr_accessor :display

  def initialize(options)
    @color = options[:color]
    @king = false
    @pos = options[:pos]
    @display = 'P'
    @board = options[:board]
  end
  
  def inspect
    @display
  end

end
