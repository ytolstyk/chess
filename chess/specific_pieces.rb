require './general_pieces.rb'

class Rook < SlidingPiece
  
  def move_dirs
    [[0, 1], [1, 0], [0, -1], [-1, 0]]
  end
  
end

class Bishop < SlidingPiece
  
  def move_dirs
    [[1, 1], [-1, 1], [1, -1], [-1, -1]]
  end
  
end

class Queen < SlidingPiece
  
  def move_dirs
    diff = [-1, 0, 1].product([-1, 0, 1])
    diff.delete([0, 0])
    diff
  end
end

class King < SteppingPiece
  
  def move_dirs
    diff = [-1, 0, 1].product([-1, 0, 1])
    diff.delete([0, 0])
    diff
  end

end

class Knight < SteppingPiece
  
  def move_dirs
    diff = [[1, 2], [1, -2], [-1, -2], [-1, 2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end
    
end

class Pawn < Piece
  attr_accessor :has_moved
  
  def initialize(pos, board, color)
    @has_moved = false
    super
  end
  
  def moves
    all_moves = []
    x, y = @pos
    self.color == :black ? (x, index = x + 1, 1) : (x, index = x - 1, -1)
    
    return [] unless on_board?([x, y])
    
    if @has_moved
      all_moves << [x, y] if @board[[x, y]].nil?
    elsif @board[[x, y]].nil?
      all_moves << [x, y]
      all_moves << [x + index, y] if @board[[x + index, y]].nil?
    end
    all_moves += attack_moves(x, y)
    all_moves
  end
  
  def attack_moves(x, y)
    attack_pos = []
    array = [-1, 1]
    array.each do |i|
      next unless on_board?([x, y + i])
      unless @board[[x, y + i]].nil? || @board[[x, y + i]].color == self.color
        attack_pos << [x, y + i]
      end
    end
    
    attack_pos 
  end
  
end 