class Board(args)
  def initialize
    @board = Array.new(8) { Array.new(nil)}
    @
    @board.each do |row|
      row[6].map! |cell| cell =  Pawn.new
      row[1].map! |cell| cell =  Pawn.new
    end
    @board.transpose
  end

  def valid_moves(piece)
    valid_moves = []
   x = piece.location[0]
   y= piece.location[1]
   possibilities = all_possible_directions(x, y)
     #filter for out_of_bounds
      #mathematical possibilities
      #check against piece.location
    possibilites.each do |coordinate|
      # if collision with white piece, return false
        x = coordinate[0]
        y = coordinate[1]
        next if out_of_bounds?(x,y)
        next if (@board[x][y]).color == piece.color
        valid_moves << coordinate
    end
    valid_moves
end

def all_possible_directions(x,y)
    possibilities = []
    (piece.moves).each do |vector|
      x += vectors[0]
      y += vector[1]
      possibilities <<  [x,y]
    end
    possibilities
end

def out_of_bounds?(x,y)
  (x < 0 || y < 0 || x > 7|| y > 7)
end

    # move to 0,2 and check a bunch
    #
    # figure out which directions are out of bounds
    #
  end

  def find_piece(location_string)
      index = string_to_index(location_string
      piece = @board[index[0]][index[1]]
      piece.location = [index[0], index[1]]
      valid_moves(piece)
  end

  def move_piece

  end

  def capture

  end

  def string_to_index(location_string)
    # a5
    col_string, row_index = location_string.split("")
    row_index = BOARDLENGTH - row_index.to_i
    col_index = col_string.downcase.ord - 97
    [row_index, col_index]
  end
end

class Player #?
end

class Piece
  attr_accessor :color, :moves, :location
  def initialize(color)
    @color = color
    @moves = moves #possible moves on an empty board
    @location = location
  end


end

class Pawn < Piece
  def initialize()

     self.moves = [1,0]
    # pawn can only move forward.
    # pawn can only move 1 space, unless it's current position is the starting col.
    # pawn can move to left front or right front diagonal
    # if opposing piece occupies that space
    # stretch: en empasse move condition
    # stretch: promotion
  end

  # TODO: deal with possible_moves method
  class Rook < Piece
  end

  class King < Piece
    def moves
      adjacent_array = []
      (-1..1).each do |rowl|
         (-1..1).each do |col|
           adjacent_array << [row, col] unless (row == 0 && col == 0)
       end
     end
  end

  class Queen < Piece
  end

  class Bishop < Piece
  end

  class Knight < Piece
  end
