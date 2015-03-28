# TODO: add "piece_captured?" and/or "capture_piece" method(s)

# require "byebug"

class Board
  attr_accessor :board, :checkmate?
  def initialize
    # @board = [Array.new(8) { Array.new(nil) }]
    # @first_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    # @second_row = Array.new(8) {Pawn.new}
    # @board[0], @board[7] = @first_row, @first_row.reverse.map! { |piece| piece.color = "black"}
    # @board[1], @board[6] = @second_row, @second_row.map! { |piece| piece.color = "black"}
    @board = [[Rook.new([0,0]), Knight.new([0, 1]), Bishop.new([0, 2]), Queen.new([0, 3]), King.new([0, 4]), Bishop.new([0, 5]), Knight.new([0, 6]), Rook.new([0,7])], [Pawn.new([1,0]), Pawn.new([1,1]), Pawn.new([1,2]), Pawn.new([1,3]), Pawn.new([1,4]), Pawn.new([1,5]), Pawn.new([1,6]), Pawn.new([1,7])], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [Pawn.new([6,0], "black"), Pawn.new([6,1], "black"), Pawn.new([6,2], "black"), Pawn.new([6,3], "black"), Pawn.new([6,4], "black"), Pawn.new([6,5], "black"), Pawn.new([6,6], "black"), Pawn.new([6, 7], "black")], [Rook.new([7, 0], "black"), Knight.new([7, 1], "black"), Bishop.new([7, 2], "black"), King.new([7, 3], "black"), Queen.new([7, 4], "black"), Bishop.new([7, 5], "black"), Knight.new([7, 6], "black"), Rook.new([7, 7], "black")]]
    @row_nums = [1,2,3,4,5,6,7,8]
    @col_letters = ["a","b","c","d","e","f","g", "h"]
    @boardlength = 8
    @display_board = ""
    @board_values = { "a1"=> [0,0], "b1"=> [0,1], "c1"=> [0,2], "d1" => [0,3], "e1" => [0,4], "f1" => [0,5], "g1" => [0,6], "h1" => [0,7], "a2" => [1,0], "b2" => [2,1], "c2" => [3,2], "d2" => [4,3], "e2" => [5,4], "f2" => [6,5], "g2" => [7,6], "h2" => [7,7], "a3" => [2,0], "b3" => [2,1], "d3" => [2,2], "e3" => [2,3], "f3" => [2,4], "g3" => [2,5], "h3" => [3,6], "f3" => [3,7], "a4" => [4,0], "b4" => [4,1], "c4" => [4,2], "d4" => [4,3], "e4" => [4,4], "f4" => [4,5], "g4" => [4,6], "h4" => [4,7], "a5" => [5,0], "b5" => [5,1], "c5" => [5,2], "d5" => [5,3], "e5" => [5,4], "f5" => [5,5], "g5" => [5,6], "h5" => [5,7], "f5" => [5,0], "a6" => [6,0], "b6" => [6,1], "c6" => [6,2], "d6" => [6,3], "e6" => [6,4], "f6" => [6,5], "g6" => [6,6], "h6" => [6,7], "a7" => [7,0], "b7" => [7,1], "c7" => [7,2], "d7" => [7,3], "e7" => [7,4], "f7" => [7,5], "g7" => [7,6], "h7" => [7,7], "a8" => [8,0], "b8" => [8,1], "c8" => [8,2], "d8" => [8,3], "e8" => [8,4], "f8" => [8,5], "g8" => [8,6], "h8" => [8,7],
                      }
  end

  def display
    format
  end

  # TODO: format is only FIRST time around. Call display_icon on an existing icon breaks it.
  #
  def format
    row_num = 8
    board_string = ""
    displayed_board = @board
    displayed_board.map! do |row|
      row.map! do |cell|
        # byebug
        cell == nil ? cell = ' ' : cell.display_icon
      end
      # byebug
      board_string += "#{row_num}   " + row.join("   ") + "\n"
      row_num -= 1
    end
    board_string += "    " + @col_letters.join("   ")
    board_string
    # displayed_board
  end

  # TODO: reconcile this with viewer/controller messages. shouldn't have to pass in old pos, just assign to piece's position before we move

  def square(x,y)
    @board[x][y]
  end

  def move(old_pos, new_pos, piece)
    piece.set_location(new_pos)
    @board[new_pos[0]][new_pos[1]] = piece
    @board[old_pos[0]][old_pos[1]] = nil
  end

  def check?(player)          #does player color put the other teams king in check?
    result = false
    team = all_pieces_same_color(player)    # all of one player's pieces on board
    all_possible_team_moves = []                  # all the potential moves by all the player's pieces
    team.each do |piece|
      valid_move(piece).each do |move|
        x = move[0]
        y = move[1]
        next if @board[x][y] == nil
        if @board[x][y].name == "king"        #if one of your valid moves equals the king
          king_location = [x,y]        # location, the king is in check
          result = true
        end
        all_possible_team_moves << move
    end
  end
      checkmate?(all_possible_team_moves, king_location) if result == true
      result
  end

  def checkmate?(all_possible_team_moves, king_location)
    king_x = king_location[0]
    king_y = king_location[1]
    team_moves.each do |move|       #if the king is in check, and your valid moves also
      valid_move(@board[king_x][king_y]) do |king_move|      # cover its valid moves, it is checkmate
         self.checkmate? = true if move == king_move
      end
    end


  end

  def all_pieces_same_color(player)
    team = []
    @board.each_with_index do |row, r_i|
      row.each_with_index.select do |col,c_i|
        next if @board[r_i][c_i] == nil
        team << @board[r_i][c_i] if @board[r_i][c_i].color == player
      end
    end
    team
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
      next if out_of_bounds?(x,y)
      if free_space?(piece, x, y)
        valid_moves << [x, y] #fix
        vector_array = check_direction(piece, x, y, move[0], move[1])
        vector_array.each { |coord| valid_moves << coord } unless piece.multiple_moves == false || vector_array == []
        # valid_moves << vector_array
      elsif (@board[x][y]).color != piece.color
        valid_moves << move
      else
        next
      end
    end
    valid_moves
  end

  def check_direction(piece, x, y, add_x, add_y, array_direction = [])
    if out_of_bounds?(x + add_x, y + add_y)
      return array_direction
    elsif friendly_fire?(piece, x + add_x, y + add_y) #&& piece.name != 'knight'
      return array_direction
    elsif free_space?(piece, x + add_x, y + add_y)
      array_direction << [x + add_x, y + add_y]
      check_direction(piece, x + add_x, y + add_y, add_x, add_y, array_direction )
    else
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

  def out_of_bounds?(x,y)
   x < 0 || y < 0 || x > 7|| y > 7
  end

  #   def find_piece(location_string)
  #       index = string_to_index(location_string)
  #       piece = @board[index[0]][index[1]]
  #       piece.location = [index[0], index[1]]
  #       valid_moves(piece)
  #   end

  def piece_captured?(piece, location)
   (square(location[0], location[1]) != nil)
 end

 def capture_piece(location)
   @captured << square(location[0], location[1])
   square(location[0], location[1]) = nil
 end

  def find_piece(location)
    piece = @board[location[0]][location[1]]
  end

  def find_piece(location_string)
    index = string_to_index(location_string)
    piece = @board[index[0]][index[1]]
  end

  def string_to_index(location_string)
    # a5
    col_string, row_index = location_string.split("")
    row_index = @boardlength - row_index.to_i
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
  attr_reader :color
  attr_accessor :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color = color
    @color =="white" ? @icon = "♚" : @icon = '♔'
    @multiple_moves = false
    @moves = [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    @name = "king"
  end
end


class Queen < Piece
  attr_reader :color
  attr_accessor :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color = color
    @color == "white" ? @icon = "♛" : @icon = '♕'
    @moves = [[1, 0], [1,1], [1, -1], [0, -1], [0, 1], [-1, 0], [-1, 1], [-1, -1]]
    @name = "queen"
  end
end

class Bishop < Piece
  attr_reader :color
  attr_accessor :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color = color
    @color == "white" ? @icon = "♝" : @icon = '♗'
    @moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @name = "bishop"
  end
end

class Knight < Piece
  attr_reader :color
  attr_accessor :moves, :multiple_moves
  def initialize(location, color = "white")
    @location = location
    @color = color
    @color == "white" ? @icon = "♞" : @icon = '♘'
    @multiple_moves = false
    @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    @name = "knight"
  end
end


b = Board.new
b.all_pieces_same_color("white")
 b.board
 board2 = Board.new
 test_board = board2.board
  test_board.each_with_index.map do |row, row_index|
      row.each_with_index.map do |col, col_index|
        test_board[row_index][col_index] = nil
      end
    end
    test_board[0][3] = King.new([0,3])
    test_board[0][4] = Queen.new([0,4], "black")
    p board2.board
    p board2.valid_move(board2.board[0][4])
    p board2.board[0][4].color
    p board2.board[0][3].color
p board2.check?("black")


 # b.move([1,3], [3,3], b.board[1][3])
# b.move([1,4], [3,4], b.board[1][4])
# b.move([1,5], [3,5], b.board[1][5])
#  b.move([7,7], [3,4], b.board[7][7])
# p b.board[3][4].name
# p b.valid_move(b.board[3][4])
# b.valid_move(b.board[0][3])
# b.display

# # p b.board