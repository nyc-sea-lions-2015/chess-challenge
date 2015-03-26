# require "byebug"

class Board
  attr_reader :board
  def initialize
    # @board = [Array.new(8) { Array.new(nil) }]
    # @first_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    # @second_row = Array.new(8) {Pawns.new}
    # @board[0], @board[7] = @first_row, @first_row.reverse.map! { |piece| piece.color = "black"}
    # @board[1], @board[6] = @second_row, @second_row.map! { |piece| piece.color = "black"}
    @board = [[" ♜ " , " ♞ ",  " ♝ ", " ♛ ",  " ♚ ",  " ♝ ",  " ♞ ",  " ♜ "], [ " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ", " ♟ "], [nil, " ♙ ",nil,nil,nil,nil,nil,nil], [nil,nil,nil,nil,nil, " ♙ ",nil,nil], [nil,nil,nil,nil,nil,nil,nil,nil],[" ♙ ",  " ♙ ",  " ♙ ", " ♙ ",  " ♙ ",nil ,  " ♙ "], [" ♖ ",  " ♘ ",  " ♗ ",  " ♕ ",  " ♔ ", " ♗ ",  " ♘ ",  " ♖ "]]
    @display_board = @board
    @col_letters = [" a ", " b ", " c "," d "," e "," f "," g "," h "]
    @whitespace = "  "
  end


  # # turns display_board into icons and nils into spaces
  # def to_icons
  #   @display_board.each do |row|
  #     row.each do |square|
  #       # if square equals piece, square = piece.value, else square = whitespace ("   ")
  #     end
  #   end
  # end
  # need this to not puts 0 to last row
  def display
    row_num = 8
    board_string = ""
    @display_board << @col_letters
    @display_board = @display_board
    @display_board.each do |col|
      # if value is a piece, turn into ascii
      # if value is nil, turn into " "
      board_string += "#{row_num}   " + col.join(" ") + "\n"
      row_num -= 1
    end
    puts board_string
  end

end

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

b = Board.new
# p b.board

b.display

#   # @board = 8 subarrays, as columns, starting at bottom left. piece objects


#   def valid_moves(piece)

    # move to 0,2 and check a bunch
    #
    # figure out which directions are out of bounds
  def out_of_bounds?(x, y)
    (x < 0 || y < 0 || x > 7 || y > 7)
  end

#     valid_moves = []
#     possibilities = []

#     x_location = piece.location[0]
#     y_location = piece.location[1]


#     (piece.moves).each do |vectors_array|

#       x_location += vectors_array[0]
#       y_location += vectors_array[1]
#       #filtered for out_of_bounds
#       next if out_of_bounds?(x_location,y_location)
#       possibilities << [x_location, y_location]

#     end

#     possibilities.each do


#       valid_moves <<
#         end



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

#     # filter for out of bounds. out of bounds if x or y < 0 || x or y > 7
#     def out_of_bounds?(x,y)
#       (x < 0 || y < 0 || x > 7 || y > 7)
#     end
#     #mathmatical possibilities
#     #check against piece.location


#     possibilites.each do |coordinate|
#       # if collision with white piece, return false
#       if @board[coordinate[0]][coordinate[1]]

#       else
#         valid_moves << coordinate


class Pawn < Piece
  attr_accessor :moves
  def initialize(color = "white")
    color == "white" ? @icon = "♟" : @icon = '♙'
    @moves = [0, 1]
  end

  # def moves(x, y)
  #     x += @moves[0]
  #     y += @moves[1]
  # end

end

  # TODO: deal with possible_moves method
  class Rook < Piece
    attr_accessor :moves
    def initialize(color = "white")
      color == "white" ? @icon = "♜" : @icon = '♖'
      @moves = [[0,1], [1,0], [-1,0], [0, -1]]
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
      @moves = [[1, 0], [1,1], [1, -1], [0, -1], [0, 1], [-1, 0], [-1, 1], [-1, -1]]
    end

  end

  class Bishop < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♝" : @icon = '♗'
      @moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end

  class Knight < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♞" : @icon = '♘'
      @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    end
  end