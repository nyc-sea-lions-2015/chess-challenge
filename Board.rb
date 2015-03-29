# TODO: add "piece_captured?" and/or "capture_piece" method(s)
#deal with white pawn movement

# TODO: deal with formatting valid moves strings
# TODO: deal with captures


# require "byebug"

class Board
  attr_accessor :board, :board_values, :checkmate
  def initialize
    @checkmate = false
    @board = [[Rook.new([0,0]), Knight.new([0, 1]), Bishop.new([0, 2]), Queen.new([0, 3]), King.new([0, 4]), Bishop.new([0, 5]), Knight.new([0, 6]), Rook.new([0,7])], [Pawn.new([1,0]), Pawn.new([1,1]), Pawn.new([1,2]), Pawn.new([1,3]), Pawn.new([1,4]), Pawn.new([1,5]), Pawn.new([1,6]), Pawn.new([1,7])], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil,nil, nil, nil], [Pawn.new([6,0], "black"), Pawn.new([6,1], "black"), Pawn.new([6,2], "black"), Pawn.new([6,3], "black"), Pawn.new([6,4], "black"), Pawn.new([6,5], "black"), Pawn.new([6,6], "black"), Pawn.new([6, 7], "black")], [Rook.new([7, 0], "black"), Knight.new([7, 1], "black"), Bishop.new([7, 2], "black"), King.new([7, 3], "black"), Queen.new([7, 4], "black"), Bishop.new([7, 5], "black"), Knight.new([7, 6], "black"), Rook.new([7, 7], "black")]]
    @col_letters = ["a","b","c","d","e","f","g", "h"]
    @boardlength = 8
    @display_board = ""
    @board_values = { "a1"=> [0,0], "b1"=> [0,1], "c1"=> [0,2], "d1" => [0,3], "e1" => [0,4], "f1" => [0,5], "g1" => [0,6], "h1" => [0,7], "a2" => [1,0], "b2" => [1,1], "c2" => [1,2], "d2" => [1,3], "e2" => [1,4], "f2" => [1,5], "g2" => [1,6], "h2" => [1,7], "a3" => [2,0], "b3" => [2,1], "c3" => [2,2], "d3" => [2,3], "e3" => [2,4], "f3" => [2,5], "g3" => [2,6], "h3" => [2,7], "a4" => [3,0], "b4" => [3,1], "c4" => [3,2], "d4" => [3,3], "e4" => [3,4], "f4" => [3,5], "g4" => [3,6], "h4" => [3,7], "a5" => [4,0], "b5" => [4,1], "c5" => [4,2], "d5" => [4,3], "e5" => [4,4], "f5" => [4,5], "g5" => [4,6], "h5" => [4,7], "a6" => [5,0], "b6" => [5,1], "c6" => [5,2], "d6" => [5,3], "e6" => [5,4], "f6" => [5,5], "g6" => [5,6], "h6" => [5,7], "a7" => [6,0], "b7" => [6,1], "c7" => [6,2], "d7" => [6,3], "e7" => [6,4], "f7" => [6,5], "g7" => [6,6], "h7" => [6,7], "a8" => [7,0], "b8" => [7,1], "c8" => [7,2], "d8" => [7,3], "e8" => [7,4], "f8" => [7,5], "g8" => [7,6], "h8" => [7,7] }
    @captured = []
  end

  def display
    format
  end

  def format
    row_num = 8
    @board_string = ""
    board_row = []
    @board.reverse.each do |row|
      @board_string += "#{row_num} "
      row.each do |cell|
        # byebug
        cell == nil ? cell = ' ' : cell = cell.display_icon
        @board_string +=" " + cell + " "
      end
      @board_string += "\n"
      row_num -= 1
    end
    @board_string += "   " +  @col_letters.join("  ")
  end

  def move(piece,new_pos)
    old_pos = piece.location
    @board[new_pos[0]][new_pos[1]] = piece
    @board[old_pos[0]][old_pos[1]] = nil
    piece.set_location(new_pos)
  end

  def square(x,y)
    @board[x][y]
  end

  def free_space?(piece, check_row, check_col)
    @board[check_row][check_col] == nil
  end

  def friendly_fire?(piece, check_row, check_col)
    return false if free_space?(piece, check_row, check_col)
    square(check_row, check_col).color == piece.color
  end

  def piece_captured?(piece, location)
    (square(location[0], location[1]) != nil)
  end

  def capture_piece(location)
    @captured << square(location[0], location[1])
    @board[location[0]][location[1]] = nil
  end

  def out_of_bounds?(location)
    x = location[0]
    y = location[1]
    (x < 0 || y < 0 || x > 7|| y > 7)
  end

  def valid_move(piece)
    valid_moves = []
    piece_moves = piece.moves
    current_location = piece.location
    piece_moves.each do |move|
      x = current_location[0] + move[0]
      y = current_location[1] + move[1]
      next if out_of_bounds?([x,y])
      if free_space?(piece, x, y)
        valid_moves << [x, y] #fix
        vector_array = check_direction(piece, x, y, move[0], move[1])
        vector_array.each { |coord| valid_moves << coord } unless piece.multiple_moves == false || vector_array == []
        # valid_moves << vector_array
      elsif (@board[x][y]).color != piece.color

        valid_moves << [x,y]
      else
        next
      end
    end
    valid_moves
  end

  def check_direction(piece, x, y, add_x, add_y, array_direction = [])
    if out_of_bounds?([x + add_x, y + add_y])
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

  def find_piece(location)
    piece = square(location[0], location[1])
  end

  def check?(player, board_state=board) #does player color put the other teams king in check?
    result = false
  team = all_pieces_same_color(player)# all of one player's pieces on board
    all_possible_team_moves = [] # all the potential moves by all the player's pieces
    team.each do |piece|
      valid_move(piece).each do |move|
        x = move[0]
        y = move[1]
        all_possible_team_moves << move
        next if @board[x][y] == nil
        if @board[x][y].name == "king" #if one of your valid moves equals the king
          king_location = [x,y] # location, the king is in check
          result = true
          checkmate?(player, all_possible_team_moves, king_location)
        end

      end
    end
    result
  end

  def checkmate?(player, all_possible_team_moves, king_location)
    king_x = king_location[0]
    king_y = king_location[1]
    valid_move(@board[king_x][king_y]).each do |king_move|
        all_possible_team_moves.include?(king_move) || #if the king is in check, and your valid moves also cover its valid moves
        king_moves_into_check?(player, king_move, king_x, king_y)
        #if king captures a location, if he is then in check
        end

        # @checkmate = true

  end

  def king_moves_into_check?(player, king_move, king_x, king_y)
     # king = @board[king_x][king_y]
     # check_board = @board.move(king, king_move)
     #  check?(player, check_board)
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
    x = @location
    if x[0] == 1 && @color == "white"
      @moves = [[1,0], [2,0]]
    elsif @color == "white"
      @moves = [[1,0]]
    elsif x[0] == 6 && @color == "black"
      @moves = [[-1,0], [-2,0]]
    else
      @moves = [[-1, 0]]
    end
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

# p b.board


# b.move([1,3], [3,3])
# b.move([1,4], [3,4])
# b.move([1,5], [3,5])
# b.move([6,1], [5,1])
# # p b.board[3][4]
# # p b.valid_move(b.board[3][4])
# p b.valid_move(b.board[5][1])
# #puts b.display
# p b.board[1][1]

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
    test_board[0][0] = King.new([0,0])
    test_board[0][1] = Queen.new([0,1], "black")
    test_board[0][2] = Rook.new([0,2], "black")
    # test_board[1][1] = Bishop.new([1,1], "black")
    p "king"
    p board2.valid_move(test_board[0][0])
    p "rook"
    p board2.valid_move(test_board[0][2])
    p "queen"
    p board2.valid_move(test_board[0][1])

    # p board2.board
p board2.check?("black")
p board2.checkmate

