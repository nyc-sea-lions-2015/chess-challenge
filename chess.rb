=begin
Classes:
 - Piece (generic rules for piece)
    * color
    * current position
    #-- specific pieces inherit --#
    - Pawn
        > possible moves
        > move history
    - Bishop
        > possible moves
    - Knight
        > possible moves
    - King
        > possible moves
    - Queen
        > possible moves

- Board = 2D array of rows
 * initialize (populates new board)
 * Current Population
 * Update
 * Checkmate?
 * Check move
   + piece type
   + clear path?


- Game
  * User Input Interface
  * Turn tracking
  * Check?

As a player I want to pick the piece to move.
- USER INPUT will be a column and row.
- BOARD will see what piece is there.
- PIECE CLASS will tell board it's possible moves.

As a player I want to choose a move.
  - GAME will prompt player for move
  - user input move to GAME
  - BOARD will check if it's a valid move.
  - BOARD will move PIECE to position (col, row) if valid
        - involves deleting PIECE from current position and
          writing it in the new position.

I want to see if I won.
  - check mate... worry about later.
=end

class King
  def initialize(color)
    #@color = color
    #@type = king
  end

  # def movement("array[row, col]")
  #   #specific rules of movement for this piece
  # end

end


# class Game
#   def initialize
#     #creates new game(Board.new)
#   end

#   def piece_select(user_input)
#     #What piece?
#     #@current_piece = gets.chomp (row, col) convert to array
#     #select_piece(array[row, col])
#   end

#   def select_move(user_input)
#     #What position
#     #@destination = gets.chomp (row, col) convert to array
#     #make_move if valid_move?(array[row, col]) == true
#   end

# end

class ChessBoard
  attr_accessor :board

  def initialize
    # Populate new board by creating a 2D array with rows (0..7)
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
    @board[4][4] = King.new("black")
  end

  # def select_piece("array[row, col]")
  #   #User inputs coordinates of piece they want to move
  #   #gets information about piece in this position
  #   #Board grabs movement(array[row, col]) from PIECE class
  #   # returns an array of coordinates
  # end

  # def valid_move?("array[row, col]")
  #   #takes move coordinates from user, compares it to piece class(possible moves)
  #   # returns a boolean.
  # end

  # def make_move
  #   # if valid move?
  #   #    - deletes selected Piece from current coordinate and writes it in new spot
  #   #
  # end

  # def to_s
  #   # Display the current state of the board by iterating through it.
  # end

end






