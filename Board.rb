# require "byebug"

class Board
  BOARDLENGTH = 8
  attr_reader :board
  def initialize
    @board = [Array.new(8) { Array.new(nil) }]
    @first_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    @second_row = Array.new(8) {Pawns.new}
    @board[0], @board[7] = @first_row, @first_row.reverse.map! { |piece| piece.color = "black"}
    @board[1], @board[6] = @second_row, @second_row.map! { |piece| piece.color = "black"}

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
    board_string = ""
    @display_board << @col_letters
    @display_board = @display_board
    @display_board.each do |col|
      # if value is a piece, turn into ascii
      # if value is nil, turn into " "
      board_string += "#{row_num}   " + col.join(" ") + "\n"
      BOARDLENGTH -= 1
    end
    puts board_string
  end

  def valid_moves(valid_moves = [])
   x = piece.location[0]
   y= piece.location[1]
   possibilities = move_one(x, y) if possibilities = [] #otherwise you get values from the recursive move check
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

def recursive_move_check(piece, check_x=0, check_y=0, valid_before_bounds_check=[])
   directions = piece.moves
   row = piece.location[0]
   col = piece.location[1]
   check_x += row         #incrementing out from current x location
   check_y += col         #incrementing out from current y location
   directions.each do |direction|
        check_x += direction[0]
        check_y += direction[1]
      if free_space?(check_x, check_y)
        valid_before_bounds_check << [check_x,check_y]
        recursive_move_check(piece, check_x, check_y, valid_before_bounds_check)
      else
        return valid_moves(valid_before_bounds_check) #base case for if it runs into a guy
      end
    end

  end

  def free_space?(check_row, check_col)
    @board[check_row][check_col] == nil
  end

def move_one(x,y)
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

  def find_piece(location_string)
      index = string_to_index(location_string
      piece = @board[index[0]][index[1]]
  end

  def string_to_index(location_string)
    # a5
    col_string, row_index = location_string.split("")
    row_index = BOARDLENGTH - row_index.to_i
    col_index = col_string.downcase.ord - 97
    [row_index, col_index]
  end
end


b = Board.new
# p b.board

b.display

class Piece
  attr_accessor :color, :moves, :location, :name
  attr_reader :display
  def initialize(color = "white")
    @all_adjacent = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
  end
end


class Pawn < Piece
  attr_accessor :moves, :first_move?, :capturing?
  def initialize(color = "white")
    color == "white" ? @icon = "♟" : @icon = '♙'
    moves = [[0, 1]]
    moves << [0,2] if first_move?
    moves << [1,1] if capturing?
    name = "pawn"
  end

end

  # TODO: deal with possible_moves method
  class Rook < Piece
    attr_accessor :moves
    def initialize(color = "white")
      color == "white" ? @icon = "♜" : @icon = '♖'
      moves = @all_adjacent - [1, 1] - [1, -1] - [-1, 1] - [-1, -1]
      name = "rook"
    end


  end

  class King < Piece
    def initialize(color = "white")
      color =="white" ? @icon = "♚" : @icon = '♔'
      @moves = @all_adjacent
      name = "king"
    end
  end


  class Queen < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♛" : @icon = '♕'
      @moves = @all_adjacent
      name = "queen"
    end
  end

  class Bishop < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♝" : @icon = '♗'
      @moves = @all_adjacent - [0,1] - [0,-1], [1,0], [-1,0]
      name = "bishop"
    end
  end

  class Knight < Piece
    def initialize(color = "white")
      color == "white" ? @icon = "♞" : @icon = '♘'
      @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
      name = "knight"
    end
  end
