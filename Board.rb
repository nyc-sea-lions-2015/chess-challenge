
# require "byebug"

class Board
  attr_reader :board_hard
  def initialize
    # @board = [Array.new(8) { Array.new(nil) }]
    # @first_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    # @second_row = Array.new(8) {Pawn.new}
    # @board[0], @board[7] = @first_row, @first_row.reverse.map! { |piece| piece.color = "black"}
    # @board[1], @board[6] = @second_row, @second_row.map! { |piece| piece.color = "black"}

    # @board_hard =  [[nil, nil, nil, nil, nil,nil, nil, nil], [Pawn.new([1,0]), nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil],  [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil]]

    @board_hard = [[Rook.new([0,0]), Knight.new([0, 1]), Bishop.new([0, 2]), Queen.new([0, 3]), King.new([0, 4]), Bishop.new([0, 5]), Knight.new([0, 6]), Rook.new([0,7])], [Pawn.new([1,0]), Pawn.new([1,1]), Pawn.new([1,2]), Pawn.new([1,3]), Pawn.new([1,4]), Pawn.new([1,5]), Pawn.new([1,6]), Pawn.new([1,7])], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [Pawn.new([6,0], "black"), Pawn.new([6,1], "black"), Pawn.new([6,2], "black"), Pawn.new([6,3], "black"), Pawn.new([6,4], "black"), Pawn.new([6,5], "black"), Pawn.new([6,6], "black"), Pawn.new([6, 7], "black")], [Rook.new([7, 0], "black"), Knight.new([7, 1], "black"), Bishop.new([7, 2], "black"), King.new([7, 3], "black"), Queen.new([7, 4], "black"), Bishop.new([7, 5], "black"), Knight.new([7, 6], "black"), Rook.new([7, 7], "black")]]
  @row_nums = [1,2,3,4,5,6,7,8]
  @col_letters = ["a","b","c","d","e","f","g", "h"]
end

def display
   row_num = 8
   board_string = ""
   @display_board = @board_hard
   @display_board.reverse.map do |row|
     row.map! do |cell|
       cell == nil ? cell = ' ' : cell.display_icon
     end.join('  ')
     board_string += "#{row_num}   " + row.join("   ") + "\n"
     row_num -= 1
   end
   board_string += "    " + @col_letters.join("   ")
 end

  end

  def move(old_pos, new_pos, piece)
    piece.set_location(new_pos)
    @board_hard[new_pos[0]][new_pos[1]] = piece
    @board_hard[old_pos[0]][old_pos[1]] = nil
  end

  #   def valid_moves(piece)
  #     valid_moves = []
  #    x = piece.location[0]
  #    y= piece.location[1]
  #    possibilities = all_possible_directions(x, y)
  #      #filter for out_of_bounds
  #       #mathematical possibilities
  #       #check against piece.location
  #     possibilites.each do |coordinate|
  #       # if collision with white piece, return false
  #         x = coordinate[0]
  #         y = coordinate[1]
  #         next if out_of_bounds?(x,y)
  #         next if (@board[x][y]).color == piece.color
  #         valid_moves << coordinate
  #     end
  #     valid_moves
  # end

  def valid_moves(valid_moves = [])
    x = piece.location[0]
    y= piece.location[1]
    valid_moves = move_one(x, y) if valid_moves == [] #otherwise you get values from the recursive move check
    #filter for out_of_bounds
    #mathematical valid_moves
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

  # def all_possible_directions(x,y)
  #     possibilities = []
  #     (piece.moves).each do |vector|
  #       x += vectors[0]
  #       y += vector[1]
  #       possibilities <<  [x,y]
  #     end
  #     possibilities
  # end

  def free_space?(check_row, check_col)
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


  def out_of_bounds?(x,y)
    (x < 0 || y < 0 || x > 7|| y > 7)
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
  attr_reader :display
  def initialize(location, color = "white")
    @location = location
    @icon = icon
    @all_adjacent = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    @location = location
  end
  def display_icon
    @icon
  end

  def set_location(new_pos)
    self.location = new_pos
  end
end


class Pawn < Piece
  attr_accessor :moves #:first_move?, :capturing?
  #logic for capturing?
  def initialize(color = "white")
    @location = location
    color == "white" ? @icon = "♟" : @icon = '♙'
    # first_move? == true if self.location[0] == 1 || self.location[0] == 6 #initial row value for pawns
    moves = [0, 1]
    # moves << [0,2] if first_move?
    # moves << [1,1] if capturing?
    name = "pawn"
  end

end

# TODO: deal with possible_moves method
class Rook < Piece
  attr_accessor :moves
  def initialize(location, color = "white")
    @location = location
    color == "white" ? @icon = "♜" : @icon = '♖'
    @moves = [[0,1], [1,0], [-1,0], [0, -1]]
    name = "rook"
  end


end

class King < Piece
  def initialize(location, color = "white")
    @location = location
    color =="white" ? @icon = "♚" : @icon = '♔'
    @moves = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    name = "king"
  end
end


class Queen < Piece
  def initialize(location, color = "white")
    @location = location
    color == "white" ? @icon = "♛" : @icon = '♕'
    @moves = [[1, 0], [1,1], [1, -1], [0, -1], [0, 1], [-1, 0], [-1, 1], [-1, -1]]
    name = "queen"
  end
end

class Bishop < Piece
  def initialize(location, color = "white")
    @location = location
    color == "white" ? @icon = "♝" : @icon = '♗'
    @moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    name = "bishop"
  end
end

class Knight < Piece
  def initialize(location, color = "white")
    @location = location
    color == "white" ? @icon = "♞" : @icon = '♘'
    @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    name = "knight"
  end
end


b = Board.new
# p b.board


b.move([1,0], [2,5], b.board_hard[1][0])
b.move([7,7], [3,4], b.board_hard[7][7])
puts b.display

