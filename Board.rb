
class Board(args)
  def initialize
    @board = [Array.new(8) { Array.new(nil) }]
    @first_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    @second_row = Array.new(8) {Pawns.new}
    @board[0], @board[7] = @first_row, @first_row.reverse.map { |piece| piece.color = "black"}
    @board[1], @board[6] = @second_row, @second_row.map { |piece| piece.color = "black"}
  end


  def valid_moves(piece)

    valid_moves = []
    possibilities = []

   x_location = piece.location[0]
   y_location = piece.location[1]
 (piece.moves).each do |vectors|

    x.location += piece.moves[0]
    y.location += piece.moves[1]

    next if out_of_bounds?(x_location, y_location)
     possibilities << [x_location, y_location]
    #mathmatical possibilities
    #check against piece.location

    possibilites.each do |coordinate|
      # if collision with white piece, return false
      if @board[coordinate[0]][coordinate[1]]

      else
        valid_moves << coordinate


    # move to 0,2 and check a bunch
    #
    # figure out which directions are out of bounds
  def out_of_bounds?(x, y)
    (x < 0 || y < 0 || x > 7 || y > 7)
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
  attr_reader :display
  def initialize(color = "white")
    color = "white" ? @icon =
    # @color = color
    # @moves = moves #possible moves on an empty board
    # @location = location
    @display_options = display[color]
  end


end

class Pawn < Piece
  def initialize(color = "white")
    color == "white" ? @icon = "♟" : @icon = '♙'
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
    def initialize(color = "white")
      color == "white" ? @icon = "♜" : @icon = '♖'
    end

  end

  class King < Piece
    def initialize(color = "white")
      color =="white" ? @icon = "♚" : @icon = '♔'
      @moves = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    end

    # def move_options(x, y)
    #   @moves.map do |vector|
    #     x += vector[0]
    #     y += vector[1]
    #   end
    # end
  end

  class Queen < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♛" : @icon = '♕'
    end

  end

  class Bishop < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♝" : @icon = '♗'
    end
  end

  class Knight < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♞" : @icon = '♘'
    end
  end
