class Player
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
end

class HumanPlayer < Player
  LETTERS = %w(a b c d e f g h)
  
  def turn(board)
    @board = board
    pos_from = ""
    pos_to = ""
    
    while true
      pos_from = prompt("[#{self.color.to_s.capitalize}] Select a piece: ")
      break if valid_piece?(pos_from)
    end
    while true
      pos_to = prompt("[#{self.color.to_s.capitalize}] Place your piece: ")
      break if valid_move?(pos_to, pos_from)
    end
    
    @board[pos_from].move(pos_from, pos_to)
  end
  
  def valid_move?(pos_to, pos_from)
    @board[pos_from].valid_moves.include?(pos_to)
  end
  
  def prompt(string)
    print string
    puts
    moving_piece = gets.downcase.split("")
    return convert(moving_piece) if on_board?(moving_piece)
    nil
  end
  
  def valid_piece?(pos)
    if pos.nil? || @board[pos].nil? || @board[pos].valid_moves.empty?
      return false
    end
    self.color == @board[pos].color
  end
  
  def convert(user_input)
    zero = "a".ord
    y = user_input[0].ord % zero
    x = 8 - user_input[1].to_i
    [x, y]
  end
  
  def on_board?(pos)
    x = pos.first
    y = pos[1].to_i
    return true if LETTERS.include?(x) && y.between?(1, 8)
    false
  end
end

class ComputerPlayer < Player
end