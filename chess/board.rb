require './general_pieces.rb'
require './specific_pieces.rb'
require 'colorize'

class Board
  ROOK_POS = [[0, 0], [7, 0], [0, 7], [7, 7]]
  KNIGHT_POS = [[0, 1], [7, 1], [0, 6], [7, 6]]
  BISH_POS = [[0, 2], [7, 2], [0, 5], [7, 5]]
  KING_POS = [[0, 4], [7, 4]]
  QUEEN_POS = [[0, 3], [7, 3]]
  PAWN_POS = [1, 6].product((0..7).to_a)
  
  SETUP = {
    Rook => ROOK_POS,
    Knight => KNIGHT_POS,
    Bishop => BISH_POS,
    King => KING_POS,
    Queen => QUEEN_POS,
    Pawn => PAWN_POS
  }
  
  DISPLAY_HASH = {NilClass => "_",
                  Rook => "R",
                  Knight => "N",
                  Bishop => "B",
                  King => "K",
                  Queen => "Q",
                  Pawn => "P"
                }
  
  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) }
    setup_board if setup
  end
  
  def setup_board
    SETUP.each do |class_name, position_array|
      position_array.each do |pos|
        color = (pos[0] < 3 ? :black : :white)
        place_piece(class_name, pos, color)
      end
    end
  end
  
  def display
    print "  |a  b  c  d  e  f  g  h "
    puts
    print "--------------------------"
    puts
    
    @grid.each_with_index do |row, index|
      print "#{row.length - index}|"
      row.each do |piece|
        color = (piece.color == :white ? :yellow : :blue) unless piece.nil?
        print " #{DISPLAY_HASH[piece.class]} ".colorize(color)
      end
      puts
    end
  end
  
  def check_mate?(color)
    in_check?(color) && any_moves?(color)
  end
  
  def in_check?(color)
    opp_color = (color == :white ? :black : :white)
    own_king_pos = king_pos(color)
    all_color(opp_color).any? do |opp_piece|
      opp_piece.moves.any? { |move| move == own_king_pos }
    end 
  end
  
  def all_color(color)
    @grid.flatten.compact.select do |el|
      el.color == color
    end
  end
  
  def king_pos(color)
    pieces.find do |piece|
      piece.class == King && piece.color == color
    end.pos
  end
  
  def is_empty?(pos)
    self[pos].nil?
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  
  def any_moves?(color)
    pieces.any? do |piece|
      next unless piece.color == color
      piece.valid_moves
    end
  end
  
  def pieces
    @grid.flatten.compact
  end
  
  def dup
    dup_board = Board.new(false)
    pieces.each do |piece|
      dup_board.place_piece(piece.class, piece.pos.dup, piece.color)
    end
    dup_board
  end
  
  def place_piece(klass, pos, color)
    self[pos] = klass.new(pos, self, color)
  end
  
end
