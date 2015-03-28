
# require 'byebug'
class Board
  attr_accessor :board
  def initialize
    # @board = [Array.new(8) { Array.new(nil) }]
    # @first_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    # @second_row = Array.new(8) {Pawn.new}
    # @board[0], @board[7] = @first_row, @first_row.reverse.map! { |piece| piece.color = "black"}
    # @board[1], @board[6] = @second_row, @second_row.map! { |piece| piece.color = "black"}

    # @board =  [[nil, nil, nil, nil, nil,nil, nil, nil], [Pawn.new([1,0]), nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil],  [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil]]


    @board = [[Rook.new([0,0]), Knight.new([0, 1]), Bishop.new([0, 2]), Queen.new([0, 3]), King.new([0, 4]), Bishop.new([0, 5]), Knight.new([0, 6]), Rook.new([0,7])], [Pawn.new([1,0]), Pawn.new([1,1]), Pawn.new([1,2]), Pawn.new([1,3]), Pawn.new([1,4]), Pawn.new([1,5]), Pawn.new([1,6]), Pawn.new([1,7])], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [Pawn.new([6,0], "black"), Pawn.new([6,1], "black"), Pawn.new([6,2], "black"), Pawn.new([6,3], "black"), Pawn.new([6,4], "black"), Pawn.new([6,5], "black"), Pawn.new([6,6], "black"), Pawn.new([6, 7], "black")], [Rook.new([7, 0], "black"), Knight.new([7, 1], "black"), Bishop.new([7, 2], "black"), King.new([7, 3], "black"), Queen.new([7, 4], "black"), Bishop.new([7, 5], "black"), Knight.new([7, 6], "black"), Rook.new([7, 7], "black")]]
    @row_nums = [1,2,3,4,5,6,7,8]
    @col_letters = ["a","b","c","d","e","f","g", "h"]
  end

  def display
    row_num = 8
    board_string = ""
    @display_board = @board
    @display_board.map do |row|
      row.map! do |cell|
        cell == nil ? cell = ' ' : cell.display_icon
      end.join('  ')
      board_string += "#{row_num}   " + row.join("   ") + "\n"
      row_num -= 1
    end
    board_string += "    " + @col_letters.join("   ")
  end

  def square(x,y)
    @board[x][y]
  end

  def move(old_pos, new_pos, piece)
    piece.set_location(new_pos)
    @board[new_pos[0]][new_pos[1]] = piece
    @board[old_pos[0]][old_pos[1]] = nil
  end

  #Friday @ 4:05 Things to figure out: 1.       2. move increments are wrong
  def free_space?(piece, check_row, check_col)
    @board[check_row][check_col] == nil
  end

  def friendly_fire?(piece, check_row, check_col)
    return false if free_space?(piece, check_row, check_col)
    square(check_row, check_col).color == piece.color
  end

  def out_of_bounds?(x,y)
    (x < 0 || y < 0 || x > 7|| y > 7)
  end

  def valid_move(piece)
    valid_moves = []
    piece_moves = piece.moves
    current_location = piece.location
    piece_moves.each do |move|
      x = current_location[0] + move[0]
      y = current_location[1] + move[1]
      # byebug
      next if out_of_bounds?(x,y)
      if free_space?(piece, x, y)
        # byebug
        valid_moves << [x, y] #fix
        vector_array = check_direction(piece, x, y, move[0], move[1])
        valid_moves << vector_array unless piece.multiple_moves == false || vector_array == []
      elsif (@board[x][y]).color != piece.color
        valid_move << move
      else
        next
      end
    end
    valid_moves
  end

  def check_direction(piece, x, y, add_x, add_y, array_direction = [])
    if out_of_bounds?(x + add_x, y + add_y)
      p "Out"
      return array_direction
    elsif friendly_fire?(piece, x + add_x, y + add_y) #&& piece.name != 'knight'
      p "friendly"
      return array_direction
    elsif free_space?(piece, x + add_x, y + add_y)
      p "free"
      array_direction << [x + add_x, y + add_y]
      check_direction(piece, x + add_x, y + add_y, add_x, add_y, array_direction )
    else
      p "opponent"
      array_direction << [x + add_x, y + add_y]
    end
    array_direction
  end

  def move_one(x,y) #returns array of piece's possible moves in 1 square radius
    valid_moves = []
    (piece.moves).each do |vector|
      x += vectors[0]
      y += vector[1]
      valid_moves <<  [x,y]
    end
  end

  def free_space?(piece, check_row, check_col)
    @board[check_row][check_col] == nil
  end

  def move_one(x,y)
    valid_moves = []
    (piece.moves).each do |vector|
      x += vectors[0]
      y += vector[1]
      valid_moves <<  [x,y]
    end
    valid_moves
  end

  #   def find_piece(location_string)
  #       index = string_to_index(location_string)
  #       piece = @board[index[0]][index[1]]
  #       piece.location = [index[0], index[1]]
  #       valid_moves(piece)
  #   end

  #   def string_to_index(location_string)
  #     # a5
  #     col_string, row_index = location_string.split("")
  #     row_index = BOARDLENGTH - row_index.to_i
  #     col_index = col_string.downcase.ord - 97
  #     [row_index, col_index]
  #   end
  # end

  def out_of_bounds?(x,y)
    (x < 0 || y < 0 || x > 7|| y > 7)
  end

  def find_piece(location_string)
    index = string_to_index(location_string)
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

class Piece
  attr_accessor :color, :moves, :location, :name
  attr_reader :display, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color = color
    @icon = icon
    @all_adjacent = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    @location = location
    @multiple_moves = true
  end
  def display_icon
    @icon
  end

  def set_location(new_pos)
    self.location = new_pos
  end
end


class Pawn < Piece
  attr_reader :color
  attr_accessor :moves, :multiple_moves #:first_move?, :capturing?
  #logic for capturing?
  def initialize(location, color = "white")
    @location = location
    @color = color
    @color == "white" ? @icon = "♟" : @icon = '♙'
    @multiple_moves = false
    # first_move? == true if self.location[0] == 1 || self.location[0] == 6 #initial row value for pawns
    @moves = [[0, 1]]
    # moves << [0,2] if first_move?
    # moves << [1,1] if capturing?
    @name = "pawn"
  end

  def moves
    @moves
  end

end

# TODO: deal with possible_moves method
class Rook < Piece
  attr_reader :color
  attr_accessor :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @multiple_moves = true
    @color = color
    @icon = @color == "white" ? "♜" : '♖'
    @moves = [[0,1], [1,0], [-1,0], [0, -1]]
    @name = "rook"
  end


end

class King < Piece
  attr_reader :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color =="white" ? @icon = "♚" : @icon = '♔'
    @multiple_moves = false
    @moves = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    @name = "king"
  end
end


class Queen < Piece
  attr_reader :moves
  def initialize(location, color = "white")
    @location = location
    @color == "white" ? @icon = "♛" : @icon = '♕'
    @moves = [[1, 0], [1,1], [1, -1], [0, -1], [0, 1], [-1, 0], [-1, 1], [-1, -1]]
    @name = "queen"
  end
end

class Bishop < Piece
  attr_reader :moves
  def initialize(location, color = "white")
    @location = location
    @color == "white" ? @icon = "♝" : @icon = '♗'
    @moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @name = "bishop"
  end
end

class Knight < Piece
  attr_reader :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color == "white" ? @icon = "♞" : @icon = '♘'
    @multiple_moves = false
    @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    @name = "knight"
  end
end


b = Board.new
# p b.board

b.move([1,0], [2,5], b.board[1][0])
b.move([7,7], [3,4], b.board[7][7])
p b.board[3][4]
p b.valid_move(b.board[3][4])
