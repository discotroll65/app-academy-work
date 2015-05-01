class HumanPlayer
  def initialize(color)
    @color = color

  end

  def get_piece_input
    puts "#{@color}, enter the piece you want to move" 
    print ">>"
    piece_pos = gets.strip
    [piece_pos]
  end

  def get_move_input
    puts "#{@color}, input your moves, seperated by commas:"
    print ">>"
    moves = gets.strip.split(',').map{|string| string.strip}
  end
end
