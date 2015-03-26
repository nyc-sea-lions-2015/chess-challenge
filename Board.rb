classes

class Board(args)
  2
  def initialize
    @board = args
  end


  def valid_moves(piece)

    valid_moves = []
    possibilities = []

   x_location = piece.location[0]
   y_location = piece.location[1]
   x_difference = piece.moves[0]
   y_difference = piece.moves[1]
   # filter for out of bounds. out of bounds if x or y < 0 || x or y > 7
   possibilities << [(x_location + x_difference), (y_location + y_difference)]
    out_of_bounds?#mathmatical possibilities
    #check against piece.location

    possibilites.each do |coordinate| 
      # if collision with white piece, return false
        if @board[coordinate[0]][coordinate[1]]

        else
          valid_moves << coordinate


    # move to 0,2 and check a bunch
    # 
    # figure out which directions are out of bounds
    #
  end

  def find_piece(location_string)
    # find the piece in the board array. (convert string to index)
    index = string_to_index(location_string)
    piece = @board[index[0]][index[1]]
    location_col, location_row = index[0], index[1]
    valid_moves(piece)
    # run valid_moves(piece)
    # return a piece object, and it's moves
  end

  def find_piece(location_string)
      index = string_to_index(location_string
      piece = @board[index[0]][index[1]]
      piece.location = [index[0], index[1]]
      valid_moves(piece)
    end
   end

  def move_piece

  end

  def capture

  end

  def string_to_index(location_string)
    # a5
    col_string, row_index = location_string.split("")
    row_index = row_index.to_i
    col_index = col_string.downcase.ord - 97
    [col_index, row_index]
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

     self.moves = [0,1]
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
  end

  class Queen < Piece
  end

  class Bishop < Piece
  end

  class Knight < Piece
  end
