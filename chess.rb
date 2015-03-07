module Movement
  def vertical(dy)
    dy
  end

  def horizontal(dx)

  end

  def diagonal(z)

  end

end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Rook
  include Movement
  attr_reader :color, :coordinates
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
  end

  def valid_move?(dx, dy)
    (dx.abs <= 7 && dy == 0) || (dx == 0 && dy.abs <= 7)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Knight
  include Movement
  attr_reader :color, :coordinates
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
   # possible_moves from [y][x]= [y+1][x-2], [y-1][x-2], [y+1][x+2], [y-1][x+2], [y+2][x-1], [y-2][x-1], [y+2][x+1], [y-2][x+1]
  end

  def valid_move?(dx, dy)
    (dx.abs == 2 && dy.abs == 1) || (dx.abs == 1 && dy.abs == 2)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Bishop
  include Movement
  attr_reader :color, :coordinates
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
  end

  def valid_move?(dx, dy)
    dx.abs = dy.abs
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Queen
  include Movement
  attr_reader :color, :coordinates
  def initialize(color, coordinates) #add x_location, y_location
    @color = color

  end

  def valid_move?(dx, dy)
    (dx.abs == dy.abs) || (dx.abs <= 7 && dy == 0) || (dx == 0 && dy.abs <= 7)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class King
  include Movement
  attr_reader :color, :coordinates
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
  end

  def valid_move?(dx, dy)
    (dx.abs == 1 && dy.abs == 1) || (dx == 0 && dy.abs == 1) || (dx.abs == 1 && dy == 0)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Pawn
  include Movement
  attr_reader :color, :coordinates
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
  end

  def valid_move?(dx, dy)
    if move_counter == 1
      if @color == "black"
        (dx == 0 && dy == -1) || (dx == 0 && dy == -2)
      elsif @color == "white"
        (dx == 0 && dy === 1) || (dx == 0 && dy = 2)
      end
    elsif move_counter > 1
      if @color == "black"
        (dx == 0 && dy == -1)
      elsif @color == "white"
        (dx == 0 && dy == 1)
      end
    else
      if @color == "black"
        (dx.abs == 1 && dy == -1)
      elsif @color == "white"
        (dx.abs == 1 && dy == 1)
      end
    end
  end
end

# Move logic
#  (Game) User will input the coordinate of the piece he wants to move first via gets.chomp (start location)
#  (Game) User will input the coordinate to move the piece to via gets.chomp (end location)
#  (Board) Calculate dx (end_x - start_x) and dy (end_x - start_x)
#  (subclass of Piece) Check if dx, dy is valid in terms of signature moves
#  (subclass of Piece) Will return that move is valid to Board
#  (Board) Will take start and end coordinates of move and will check path for validity
#  (Board) If valid, will write over Board with new placement of specific piece
#  (Piece) If valid, will reset location to new location




class Board
  attr_reader :board

  def initialize(height = 8, width = 8)
    @height, @width = height, width
    @board = Array.new(height) {Array.new(width)}

    #fill the board using [y][x]
    #y is the row and x is the column
    (0..7).each do |x|
      @board[x][1] = Pawn.new("black", [x, 1]) #add x_location, y_location
      @board[x][6] = Pawn.new("white", [x, 6]) #add x_location, y_location
    end

    @board[0][0] = Rook.new("black", [0, 0]) #add x_location, y_location
    @board[1][0] = Knight.new("black", [1, 0]) #add x_location, y_location
    @board[2][0] = Bishop.new("black", [2, 0]) #add x_location, y_location
    @board[3][0] = Queen.new("black", [3, 0]) #add x_location, y_location
    @board[4][0] = King.new("black", [4, 0]) #add x_location, y_location
    @board[5][0] = Bishop.new("black", [5, 0]) #add x_location, y_location
    @board[6][0] = Knight.new("black", [6, 0]) #add x_location, y_location
    @board[7][0] = Rook.new("black", [7, 0]) #add x_location, y_location

    @board[0][7] = Rook.new("white", [0, 7]) #add x_location, y_location
    @board[1][7] = Knight.new("white", [1, 7]) #add x_location, y_location
    @board[2][7] = Bishop.new("white", [2, 7]) #add x_location, y_location
    @board[3][7] = King.new("white", [3, 7]) #add x_location, y_location
    @board[4][7] = Queen.new("white", [4, 7]) #add x_location, y_location
    @board[5][7] = Bishop.new("white", [5, 7]) #add x_location, y_location
    @board[6][7] = Knight.new("white", [6, 7]) #add x_location, y_location
    @board[7][7] = Rook.new("white", [7, 7]) #add x_location, y_location
  end

    #set a width(8) and a height(8)
    #create an array of piece objects (e.g. @board = Array.new(@width) {[]})

    #location of pieces
    #add pieces to the board
    #create board

    #board = ['Rook.new(color)']

  def self.board
     #for players white and black: make all of these things -------
                      #board = ['Rook.new(rook, color)']
      #make eight pawns
      #make two rooks pieces
      #make one king piece
      #make one queen piece
      #make two bishop pieces
      #make two knight pieces
  end

  def space(x,y)

  end

  def check_path(start_coordinates, end_coordinates)


  #to see if the move is valid based on the pieces movement
  #to see if there is a "piece" in the way
  #look at a piece and give you a subset of available options
  end


end

class Game
  def initialize
  end
end

game = Board.new
p game.board[0][0].vertical(3)