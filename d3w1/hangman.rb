require './human_player.rb'
require './game.rb'
require './computer_player.rb'

scott = HumanPlayer.new
computer = ComputerPlayer.new
computer2 = ComputerPlayer.new
#Game.new(guessing_player, checking_player)
game = Game.new(computer, computer2)
game.play
