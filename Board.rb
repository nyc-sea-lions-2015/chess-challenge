# require "byebug"

class Board
  attr_reader :board
  def initialize
    # @board = [[" ♜ " , " ♞ ",  " ♝ ", " ♛ ",  " ♚ ",  " ♝ ",  " ♞ ",  " ♜ "], [ " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ",  " ♟ ", " ♟ "], ["   ","   ","   ","   ","   ","   ","   ","   "],["   ","   ","   ","   ","   ","   ","   ","   "], ["   ","   ","   ","   ","   ","   ","   ","   "], ["   ","   ","   ","   ","   ","   ","   ","   "], [" ♙ ",  " ♙ ",  " ♙ ", " ♙ ",  " ♙ ",  " ♙ ",  " ♙ ",  " ♙ "], [" ♖ ",  " ♘ ",  " ♗ ",  " ♕ ",  " ♔ ", " ♗ ",  " ♘ ",  " ♖ "]]
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

b = Board.new
# p b.board

b.display

#   # @board = 8 subarrays, as columns, starting at bottom left. piece objects

#   def valid_moves(piece)

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


#         # move to 0,2 and check a bunch
#         #
#         # figure out which directions are out of bounds
#         #
#       end

#       def find_piece(location_string)
#         # find the piece in the board array. (convert string to index)
#         index = string_to_index(location_string)
#         piece = @board[index[0]][index[1]]
#         location_col, location_row = index[0], index[1]
#         valid_moves(piece)
#         # run valid_moves(piece)
#         # return a piece object, and it's moves
#       end

#       def find_piece(location_string)
#         index = string_to_index(location_string)
#         piece = @board[index[0]][index[1]]
#         piece.location = [index[0], index[1]]
#         valid_moves(piece)
#       end
#     end
#   end

#   def move_piece

#   end

#   def capture

#   end

#   def string_to_index(location_string)
#     # a5
#     col_string, row_index = location_string.split("")
#     row_index = row_index.to_i
#     col_index = col_string.downcase.ord - 97
#     [col_index, row_index]
#   end
# end

# class Player #?
# end

# class Piece
#   attr_accessor :color, :moves, :location
#   def initialize(color)
#     @color = color
#     @moves = moves #possible moves on an empty board
#     @location = location
#   end


# end

# class Pawn < Piece
#   def initialize()

#     self.moves = [0,1]
#     # pawn can only move forward.
#     # pawn can only move 1 space, unless it's current position is the starting col.
#     # pawn can move to left front or right front diagonal
#     # if opposing piece occupies that space
#     # stretch: en empasse move condition
#     # stretch: promotion
#   end

#   # TODO: deal with possible_moves method
#   class Rook < Piece
#   end

#   class King < Piece
#   end

#   class Queen < Piece
#   end

#   class Bishop < Piece
#   end

#   class Knight < Piece
#   end
