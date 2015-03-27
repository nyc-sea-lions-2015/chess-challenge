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

  def valid_moves(piece)
    valid_moves = []
   x = piece.location[0]
   y= piece.location[1]
   possibilities = move_one(x, y)
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

def recursive_move_check(piece)
   row = piece.location[0]
   col = piece.location[1]
    (piece.moves).each do |vector|
      x = vector[0] + row
      y = vector[1] + col
      if match?(x, y)
        count_more_in_same_direction(direction, adjacent_r, adjacent_c, count=2)
      end
    end
  end
  def match?(comp_row, comp_col)
    @board[comp_row][comp_col] != nil
  end

  def count_more_in_same_direction(direction, row, col, count)
    @count = count
    x = (piece.moves)[direction][0] + row
    y = (piece.moves)[direction][1] + col
    if match?(x, y)
        valid_moves << [x, y]
      count_more_in_same_direction(direction, x, y, count+1)
    end
  end


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
  attr_accessor :color, :moves, :location
  attr_reader :display
  def initialize(color = "white")
  end
end


class Pawn < Piece
  attr_accessor :moves
  def initialize(color = "white")
    color == "white" ? @icon = "♟" : @icon = '♙'
    @moves = [0, 1]
  end

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
