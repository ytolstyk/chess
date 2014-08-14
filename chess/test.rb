require_relative 'game'


puts '1. Moves does not include moves that put self in check'

b = Board.new(false)
b.place_piece(King, [0, 0], :white)
b.place_piece(Rook, [0, 1], :white)
b.place_piece(Rook, [0, 2], :black)

piece = b[[0, 1]]
puts piece.valid_moves == [[0, 2]]

puts "2. Gets right moves for pawn"

c = Board.new(false)
c.place_piece(Pawn, [0,0], :white)
piece = c[[0, 0]]
puts piece.moves == [[1, 0], [2, 0]]

puts '3. Check mate works'

d = Board.new(false)
d.place_piece(King, [0, 0], :white)
d.place_piece(Rook, [0, 7], :black)
d.place_piece(Rook, [1, 6], :black)
d.place_piece(King, [7, 7], :black)

king = d[[0, 0]]
puts d.check_mate?(king.color) == true



