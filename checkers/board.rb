require_relative 'piece.rb'
require 'pry'
require 'colorize'
class Board
  attr_reader :grid

  def initialize(setup = true)
    @grid = Array.new(8) {Array.new(8) {nil} }
    @setup = setup
    self.setup_board if setup
  end

  def show_board

  end



 private
  def setup_board

  end


end
