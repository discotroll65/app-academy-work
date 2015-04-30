class Piece
  attr_reader: :color, :king, :pos

  def initialize(options)
    @color = options[:color]
    @king = false
    @pos = options[:pos]
  end

end
