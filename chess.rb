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

class Piece
  attr_accessor :position
  def initialize(color, position)
    @color = color
    @position = position
  end
end

class King < Piece
  attr_reader :possible_moves, :color
  def initialize(color, position)
    super
    @possible_moves = []
  end

  def movement(board)
    (-1..1).each do |dy|
      (-1..1).each do |dx|
        y_pos = position[0] - dy
        x_pos = position[1] - dx
        if board[y_pos][x_pos] == "-" || board[y_pos][x_pos].color != @color
          @possible_moves << [y_pos,x_pos]
        end
      end
    end
    @possible_moves
  end
end

class Pawn < Piece
  attr_reader :possible_moves, :color
  attr_accessor :move_counter
  def initialize(color, position)
    super
    @possible_moves = []
    @move_counter = 0
  end

  def movement(board)
    if @color == "white"
      if @move_counter == 0
        (1..2).each do |y|
          y_pos = @position[0] - y
          p y_pos
          if board[y_pos][position[1]] == "-"
            @possible_moves << [y_pos, position[1]]
          else
            break
          end
        end
      else
        y_pos = @position[0]-1
        if board[y_pos][position[1]] == "-"
          @possible_moves << [y_pos, position[1]]
        end
      end
      [[-1,-1],[-1,1]].each do |dy, dx|
        y_pos = position[0] + dy
        x_pos = position[1] + dx
        if board[y_pos][x_pos] != "-"
          @possible_moves << [y_pos, x_pos] if board[y_pos][x_pos].color != @color
        end
      end
    else #black
      if @move_counter == 0
        (1..2).each do |y|
          y_pos = @position[0] + y
          p y_pos
          if board[y_pos][position[1]] == "-"
            @possible_moves << [y_pos, position[1]]
          else
            break
          end
        end
      else
        y_pos = @position[0]+1
        if board[y_pos][position[1]] == "-"
          @possible_moves << [y_pos, position[1]]
        end
      end
      [[1,1],[1,-1]].each do |dy, dx|
        y_pos = position[0] + dy
        x_pos = position[1] + dx
        if board[y_pos][x_pos] != "-"
          @possible_moves << [y_pos, x_pos] if board[y_pos][x_pos].color != @color
        end
      end
    end
    @possible_moves
  end
end

class Rook < Piece
  attr_reader :possible_moves, :color
  def initialize(color, position)
    super
    @possible_moves = []
  end

  def movement(board)
    #up
    -1.downto(-7) do |dy|
      y_pos = position[0] - dy
      # puts y_pos
      if y_pos.between?(0,7)
        if board[y_pos][position[1]] == "-"
          @possible_moves << [y_pos, position[1]]
        else
          # puts "Original: #{@color}"
          # puts "Obstruction: #{board[y_pos][position[1]].color}"
          if board[y_pos][position[1]].color != @color
            @possible_moves << [y_pos, position[1]]
            break
          else
            # @possible_moves << [y_pos, position[1]]
            break
          end
        end
      end
    end

    #down
    1.upto(7) do |dy|
      y_pos = position[0] - dy
      if y_pos.between?(0,7)
        if board[y_pos][position[1]] == "-"
          @possible_moves << [y_pos, position[1]]
        else
          # puts "Original: #{@color}"
          # puts "Obstruction: #{board[y_pos][position[1]].color}"
          if board[y_pos][position[1]].color != @color
            @possible_moves << [y_pos, position[1]]
            break
          else
            # @possible_moves << [y_pos, position[1]]
            break
          end
        end
      end
    end

    #left
    -1.downto(-7) do |dx|
      x_pos = position[1] - dx
      # puts y_pos
      if x_pos.between?(0,7)
        if board[position[0]][x_pos] == "-"
          @possible_moves << [position[0], x_pos]
        else
          if board[position[0]][x_pos].color == @color
            # @possible_moves << [y_pos, position[1]]
            break
          else
            @possible_moves << [position[0], x_pos]
            break
          end
        end
      end
    end

    # #right
    1.upto(7) do |dx|
      x_pos = position[1] - dx
      # puts y_pos
      if x_pos.between?(0,7)
        if board[position[0]][x_pos] == "-"
          @possible_moves << [position[0], x_pos]
        else
          if board[position[0]][x_pos].color == @color
            # @possible_moves << [y_pos, position[1]]
            break
          else
            @possible_moves << [position[0], x_pos]
            break
          end
        end
      end
    end
  @possible_moves
  end
end

class Bishop < Piece
  attr_reader :possible_moves, :color
  def initialize(color, position)
    super
    @possible_moves = []
  end

  def movement(board)
    movement_top_left(board)
    movement_bottom_right(board)
    movement_top_right(board)
    movement_bottom_left(board)
  end
  #checks diagnol from piece to top left
  def movement_top_left(board)
    (1..7).each do |num|
      dy, dx = num, num
      y_pos = position[0] - dy
      x_pos = position[1] - dx
      if y_pos < 0 || x_pos < 0
        next
      else
        if board[y_pos][x_pos] == "-"
          @possible_moves << [y_pos, x_pos]
        else
          if board[y_pos][x_pos].color != @color
            @possible_moves << [y_pos, x_pos]
            return @possible_moves
          else
            return @possible_moves
          end
        end
      end
    end
    @possible_moves
  end
    #checks diagnol from piece to bottom_left
  def movement_bottom_right(board)
    (1..7).each do |num|
      dy, dx = num, num
      y_pos = position[0] + dy
      x_pos = position[1] + dx
      if y_pos > 7 || x_pos > 7
        next
      else
        if board[y_pos][x_pos] == "-"
          @possible_moves << [y_pos, x_pos]
        else
          if board[y_pos][x_pos].color != @color
            @possible_moves << [y_pos, x_pos]
            return @possible_moves
          else
            return @possible_moves
          end
        end
      end
    end
    @possible_moves
  end
  #checks diagnol from piece to top_right
  def movement_top_right(board)
    (1..7).each do |num|
      dy, dx = num, num
      y_pos = position[0] - dy
      x_pos = position[1] + dx
      if y_pos < 0 || x_pos > 7
        next
      else
        if board[y_pos][x_pos] == "-"
          @possible_moves << [y_pos, x_pos]
        else
          if board[y_pos][x_pos].color != @color
            @possible_moves << [y_pos, x_pos]
            return @possible_moves
          else
            return @possible_moves
          end
        end
      end
    end
    @possible_moves
  end
    #checks diagnol from piece to bottom_left
  def movement_bottom_left(board)
    (1..7).each do |num|
        dy, dx = num, num
        y_pos = position[0] + dy
        x_pos = position[1] - dx
        if y_pos > 7 || x_pos < 0
          next
        else
          if board[y_pos][x_pos] == "-"
            @possible_moves << [y_pos, x_pos]
          else
            if board[y_pos][x_pos].color != @color
              @possible_moves << [y_pos, x_pos]
              return @possible_moves
            else
              return @possible_moves
            end
          end
        end
    end
    @possible_moves
  end
end

class Queen < Piece
  attr_reader :possible_moves, :color
  def initialize(color, position)
    super
    @possible_moves = []
  end

  def movement(board)
    movement_top_left(board)
    movement_bottom_right(board)
    movement_top_right(board)
    movement_bottom_left(board)
    movement_up(board)
    movement_down(board)
    movement_right(board)
    movement_left(board)
  end
  #checks diagnol from piece to top left
  def movement_top_left(board)
    (1..7).each do |num|
      dy, dx = num, num
      y_pos = position[0] - dy
      x_pos = position[1] - dx
      if y_pos < 0 || x_pos < 0
        next
      else
        if board[y_pos][x_pos] == "-"
          @possible_moves << [y_pos, x_pos]
        else
          if board[y_pos][x_pos].color != @color
            @possible_moves << [y_pos, x_pos]
            return @possible_moves
          else
            return @possible_moves
          end
        end
      end
    end
    @possible_moves
  end
    #up
    def movement_up(board)
      -1.downto(-7) do |dy|
        y_pos = position[0] - dy
        # puts y_pos
        if y_pos.between?(0,7)
          if board[y_pos][position[1]] == "-"
            @possible_moves << [y_pos, position[1]]
          else
            # puts "Original: #{@color}"
            # puts "Obstruction: #{board[y_pos][position[1]].color}"
            if board[y_pos][position[1]].color != @color
              @possible_moves << [y_pos, position[1]]
              break
            else
              # @possible_moves << [y_pos, position[1]]
              break
            end
          end
        end
      end
      @possible_moves
    end

    #down
    def movement_down(board)
      1.upto(7) do |dy|
        y_pos = position[0] - dy
        if y_pos.between?(0,7)
          if board[y_pos][position[1]] == "-"
            @possible_moves << [y_pos, position[1]]
          else
            # puts "Original: #{@color}"
            # puts "Obstruction: #{board[y_pos][position[1]].color}"
            if board[y_pos][position[1]].color != @color
              @possible_moves << [y_pos, position[1]]
              break
            else
              # @possible_moves << [y_pos, position[1]]
              break

            end
          end
        end
      end
      @possible_moves
    end
  #checks diagnol from piece to bottom_left
  def movement_bottom_right(board)
    (1..7).each do |num|
      dy, dx = num, num
      y_pos = position[0] + dy
      x_pos = position[1] + dx
      if y_pos > 7 || x_pos > 7
        next
      else
        if board[y_pos][x_pos] == "-"
          @possible_moves << [y_pos, x_pos]
        else
          if board[y_pos][x_pos].color != @color
            @possible_moves << [y_pos, x_pos]
            return @possible_moves
          else
            return @possible_moves
          end
        end
      end
    end
    @possible_moves
  end


    #left
    def movement_left(board)
      -1.downto(-7) do |dx|
        x_pos = position[1] - dx
        # puts y_pos
        if x_pos.between?(0,7)
          if board[position[0]][x_pos] == "-"
            @possible_moves << [position[0], x_pos]
          else
            if board[position[0]][x_pos].color == @color
              # @possible_moves << [y_pos, position[1]]
              break
            else
              @possible_moves << [position[0], x_pos]
              break
            end
          end
        end
      end
      @possible_moves
    end

    # #right
    def movement_right(board)
      1.upto(7) do |dx|
        x_pos = position[1] - dx
        # puts y_pos
        if x_pos.between?(0,7)
          if board[position[0]][x_pos] == "-"
            @possible_moves << [position[0], x_pos]
          else
            if board[position[0]][x_pos].color == @color
              # @possible_moves << [y_pos, position[1]]
              break
            else
              @possible_moves << [position[0], x_pos]
              break
            end
          end
        end
      end
      @possible_moves
    end
  #checks diagnol from piece to top_right
  def movement_top_right(board)
    (1..7).each do |num|
      dy, dx = num, num
      y_pos = position[0] - dy
      x_pos = position[1] + dx
      if y_pos < 0 || x_pos > 7
        next
      else
        if board[y_pos][x_pos] == "-"
          @possible_moves << [y_pos, x_pos]
        else
          if board[y_pos][x_pos].color != @color
            @possible_moves << [y_pos, x_pos]
            return @possible_moves
          else
            return @possible_moves
          end
        end
      end
    end
    @possible_moves
  end
  #checks diagnol from piece to bottom_left
  def movement_bottom_left(board)
    (1..7).each do |num|
        dy, dx = num, num
        y_pos = position[0] + dy
        x_pos = position[1] - dx
        if y_pos > 7 || x_pos < 0
          next
        else
          if board[y_pos][x_pos] == "-"
            @possible_moves << [y_pos, x_pos]
          else
            if board[y_pos][x_pos].color != @color
              @possible_moves << [y_pos, x_pos]
              return @possible_moves
            else
              return @possible_moves
            end
          end
        end
    end
    @possible_moves
  end
end

class Knight < Piece
  attr_reader :possible_moves, :color
  def initialize(color, position)
    super
    @possible_moves = []
  end

  def movement(board)
    [[-2,1],[-2,-1],[2,1],[2,-1],[1,-2],[1,2],[-1,-2],[-1,2]].each do |dy, dx|
        y_pos = position[0] - dy
        x_pos = position[1] - dx
        y_pos.between?(0,7) && x_pos.between?(0,7) ? coord = board[y_pos][x_pos] : coord = nil
        unless coord == nil
          if coord == "-" || coord.color != self.color
            @possible_moves << [y_pos,x_pos]
          end
        end
    end
    @possible_moves
  end
end

class ChessBoard
  attr_accessor :board

  def initialize
    # Populate new board by creating a 2D array with rows (0..7)
    @board = Array.new(8) {["-","-","-","-","-","-","-","-"]}
    # @board[4][4] = King.new("black", [4,4])
    @board[4][4] = Queen.new("black", [4,4])
    @board[3][3] = Bishop.new("black", [3,3])
    @board[1][1] = Bishop.new("black", [1,1])
    @board[5][2] = Bishop.new("black", [5,2])
    @board[6][1] = Pawn.new("white", [6,1])
    @board[1][5] = Pawn.new("black", [1,5])
    @board[2][4] = Pawn.new("white", [2,4])

  end

  def select_piece(array, player_color)
    col = array[0]
    row = array[1]
    #User inputs coordinates of piece they want to move
    #gets information about piece in this position
    #Board grabs movement(array[row, col]) from PIECE class
    # returns an array of coordinates
    if @board[col][row] != "-" && @board[col][row].color == player_color
      @board[col][row].movement(@board)
    else
      nil
    end
  end

  def valid_move?(optional_moves, move)
    return true if optional_moves.include?(move)
    return false
    #takes move coordinates from user, compares it to piece class(possible moves)
    # returns a boolean.
  end

  # def make_move
  #   # if valid move?
  #   #    - deletes selected Piece from current coordinate and writes it in new spot
  #   #
  # end

  # def to_s
  #   # Display the current state of the board by iterating through it.
  # end

end

class Game
  attr_reader :user_piece, :user_move, :new_game, :valid_moves
  def initialize
    @new_game = ChessBoard.new
    @player = true
    @player_color = "white"
  end

  def turn
    if @player == true
      white_turn
      @player = false
      @player_color = "black"
    else
      #next player's turn
      black_turn
      @player = true
      @player_color = "white"
    end

  end

  def white_turn
    valid_piece = false
    until valid_piece
      puts "Player White select piece to move: "
      @user_piece = gets.chomp.split("") #get number ex: 75 02 33
      @user_piece[0], @user_piece[1] = @user_piece[0].to_i, @user_piece[1].to_i
      if piece_select
        valid_piece = true
      else
        puts "Try again."
      end
    end
    valid_move = false
    until valid_move
      puts "Choose spot to move: "
      @user_move = gets.chomp.split("")
      @user_move[0], @user_move[1] = @user_move[0].to_i, @user_move[1].to_i
      if @new_game.valid_move?(@valid_moves, @user_move)
        valid_move = true
        puts "Valid Move"
      else
        puts "Invalid move"
      end
    end
  end

  def black_turn
    valid_piece = false
    until valid_piece
      puts "Player Black select piece to move: "
      @user_piece = gets.chomp.split("") #get number ex: 75 02 33
      @user_piece[0], @user_piece[1] = @user_piece[0].to_i, @user_piece[1].to_i
      piece_select
      if piece_select
        valid_piece = true
      else
        puts "Try again."
      end
    end
    valid_move = false
    until valid_move
      puts "Choose spot to move: "
      @user_move = gets.chomp.split("")
      @user_move[0], @user_move[1] = @user_move[0].to_i, @user_move[1].to_i
      if @new_game.valid_move?(@valid_moves, @user_move)
        valid_move = true
        puts "Valid Move"
      else
        puts "Invalid move"
      end
    end
  end

  def piece_select
    p @user_piece
    p @valid_moves = @new_game.select_piece(@user_piece, @player_color)
    #What piece?
    #@current_piece = gets.chomp (row, col) convert to array
    #select_piece(array[row, col])
  end

#   def select_move
#     p @user_move
#     if @new_game.valid_move?(@valid_moves, @user_move)
#       puts valid = true
#     else
#       puts "Invalid move"
# #     #What position
# #     #@destination = gets.chomp (row, col) convert to array
# #     #make_move if valid_move?(array[row, col]) == true
#     end
#   end

end

test = Game.new
test.turn
test.turn
test.turn
test.turn

