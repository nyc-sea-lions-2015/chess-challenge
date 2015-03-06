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
        if board[y_pos][x_pos] == "-" || board[y_pos][x_pos].color != self.color
          @possible_moves << [y_pos,x_pos]
        end
      end
    end
    @possible_moves
  end
end


# I want to start at the position and move only one coordinate until I hit the end of the board.
# Needs a left-right movement
# Needs a up-down movement
# Needs to stop if position is greater than 7 or less than 0
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
    top_board = []
    bottom_board = []
    #checks diagnol from bottom right to top left
    (-7..7).each do |num|
      pos = position[0] - num
      if pos.between?(0,7)

        if (pos + pos) > (position[0] + position[1])
          p "pos = #{pos}"
          p "posiblemoves = #{@possible_moves}"
          if board[pos][pos] != '-'
            bottom_board << @possible_moves.each {|x| x} #bottom board taking all @possible values????
          end
        else
          if board[pos][pos] != '-'
            top_board << [pos,pos]
          end
        end

        if board[pos][pos] == "-" || board[pos][pos].color != self.color
          @possible_moves << [pos, pos]
        end
      else
        next
      end
    end
    p bottom_board
    p top_board
    @possible_moves = @possible_moves - (bottom_board + top_board)
    #checks diagnol from bottom left to top right
    (-7..7).each do |dy|
      (-7..7).each do |dx|
        y_pos = position[0] - dy
        x_pos = position[1] - dx
        if y_pos.between?(0,7) && x_pos.between?(0,7)
          if (y_pos + x_pos) == (position[0] + position[1])
            # if board[pos][pos].color != self.color || board[pos][pos].color == self.color
            #   bottom_board = @possible_moves
            # end
            if board[y_pos][x_pos] == "-" || board[y_pos][x_pos].color != self.color
              @possible_moves << [y_pos, x_pos]
            end
          end
        else
          next
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

    #checks diagnol from top left to bottom right
    (-7..7).each do |num|
      pos = position[0] - num
      if pos.between?(0,7)
        if board[pos][pos] == "-" || board[pos][pos].color != self.color
          @possible_moves << [pos, pos]
        end
      else
        next
      end
    end

    #checks diagnol from bottom left to top right
    (-7..7).each do |dy|
      (-7..7).each do |dx|
        y_pos = position[0] - dy
        x_pos = position[1] - dx
        if y_pos.between?(0,7) && x_pos.between?(0,7)
          if (y_pos + x_pos) == (position[0] + position[1])
            if board[y_pos][x_pos] == "-" || board[y_pos][x_pos].color != self.color
              @possible_moves << [y_pos, x_pos]
            end
          end
        else
          next
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
    # @board[4][4] = Queen.new("black", [4,4])
    # @board[3][3] = Bishop.new("black", [3,3])
    @board[4][4] = Rook.new("white", [4,4])
    @board[2][4] = Bishop.new("black", [2,4])
    @board[4][2] = Queen.new("white", [4,2])
    @board[6][4] = Knight.new("white", [6,4])

  end

  def select_piece(array)
    col = array[0]
    row = array[1]
    #User inputs coordinates of piece they want to move
    #gets information about piece in this position
    #Board grabs movement(array[row, col]) from PIECE class
    # returns an array of coordinates
    @board[col][row].movement(@board)
  end

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




