require 'debugger'
class Piece
  attr_accessor :pos, :color
  
  def initialize(pos, board, color)
    @board = board
    @pos = pos
    @color = color
  end
  
  def move(pos_from, pos_to)
    @board[pos_from] = nil
    @board[pos_to] = self
    self.pos = pos_to
  end
  
  def valid_moves
    moves.select do |move|
      dup_board = @board.dup
      piece_dup = dup_board[@pos]
      piece_dup.move(@pos, move)
      !dup_board.in_check?(piece_dup.color)
    end
  end
  
  def not_checked?(pos_from, pos_to)
    new_board = @board.dup
    new_board[pos_from].move(pos_from, pos_to)
    !new_board.in_check?(self.color)
  end
  
  def on_board?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end
  
  def inspect
    self.class.to_s[0..1]
  end
end

class SlidingPiece < Piece
  
  def moves
    x, y = @pos
    all_moves = []
    
    move_dirs.each do |diff|
      (1..7).each do |i|
        new_x = x + (diff.first * i)
        new_y = y + (diff.last * i)
        
        break unless on_board?([new_x, new_y])
        if @board[[new_x, new_y]].nil?
          all_moves << [new_x, new_y] 
        elsif @board[[new_x, new_y]].color == self.color
          break
        else
          all_moves << [new_x, new_y]
          break
        end
      end
    end

    all_moves.delete(pos)
    all_moves
  end
end

class SteppingPiece < Piece
    
  def moves
    x, y = @pos
    all_moves = []
    move_dirs.each do |move|
      new_x = x + move.first
      new_y = y + move.last
      all_moves << [new_x, new_y] if on_board?([new_x, new_y])
    end
    legal_moves(all_moves)
  end
  
  def legal_moves(moves)
    moves.select do |move|
      @board[move].nil? || @board[move].color != self.color
    end
  end
end