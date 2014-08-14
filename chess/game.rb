require './board.rb'
require './player.rb'

class Game
  
  def initialize(player_one = HumanPlayer, player_two = HumanPlayer)
    @board = Board.new
    @player_one = player_one.new(:white)
    @player_two = player_two.new(:black)
  end
  
  def play
    until check_mate?
      @board.display
      @player_one.turn(@board)
      is_in_check?(@player_two.color)
      break if check_mate(@player_two.color)
      @board.display
      @player_two.turn(@board)
      is_in_check?(@player_one.color)
      
    end
    puts
    puts "Checkmate!"
  end
  
  def is_in_check?(color)
    puts "#{color.to_s.capitalize} is in check!" if @board.in_check?(color)
  end
  
  def check_mate(color)
    @board.check_mate?(color)
  end
  
  def check_mate?
    check_mate(@player_one.color) || check_mate(@player_two.color)
  end
  
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end