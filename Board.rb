classes

class Board(args)
	2
  def initialize
    @board = args
  end

  def valid_moves

  end

  def find_piece_type

  end

  def move_piece

  end

  def capture

  end
end

class Player #?
end

class Piece
  def initialize(color)
    @color = color
  end

  def possible_moves
  end
end

class Pawn < Piece

end

# TODO: deal with possible_moves method
class Rook < Piece
end

class King < Piece
end

class Queen < Piece
end

class Bishop < Piece
end

class Knight < Piece
end
