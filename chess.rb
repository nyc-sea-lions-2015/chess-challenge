module Movement

  def vertical(dy)
    self.y += dy

  end

  def horizontal(dx)
    self.x += dx
  end

  def diagonal(z)
    self.x += z
    self.y += z
  end

end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Rook
  include Movement
  attr_accessor :color, :x, :y
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
    @x = coordinates[0]
    @y = coordinates[1]
  end

  def valid_move?(dx, dy)
    (dx.abs <= 7 && dy == 0) || (dx == 0 && dy.abs <= 7)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Knight
  include Movement
  attr_accessor :color, :x, :y
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
    @x = coordinates[0]
    @y = coordinates[1]
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
  attr_accessor :color, :x, :y
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
    @x = coordinates[0]
    @y = coordinates[1]
  end

  def valid_move?(dx, dy)
    dx.abs = dy.abs
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Queen
  include Movement
  attr_accessor :color, :x, :y
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
    @x = coordinates[0]
    @y = coordinates[1]
  end

  def valid_move?(dx, dy)
    (dx.abs == dy.abs) || (dx.abs <= 7 && dy == 0) || (dx == 0 && dy.abs <= 7)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class King
  include Movement
  attr_accessor :color, :x, :y
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
    @x = coordinates[0]
    @y = coordinates[1]
  end

  def valid_move?(dx, dy)
    (dx.abs == 1 && dy.abs == 1) || (dx == 0 && dy.abs == 1) || (dx.abs == 1 && dy == 0)
  end
end

# pass current_position for current_y, current_x and where
# they want to move it to move_position for move_x, move_y
class Pawn
  include Movement
  attr_accessor :color, :x, :y
  def initialize(color, coordinates) #add x_location, y_location
    @color = color
    @x = coordinates[0]
    @y = coordinates[1]
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

  def initialize
    @board = []

    #fill the board using [y][x]
    #y is the row and x is the column
    
    

    @board << Rook.new("black", [0, 7]) 
    @board << Knight.new("black", [1, 7]) 
    @board << Bishop.new("black", [2, 7]) 
    @board << Queen.new("black", [3, 7]) 
    @board << King.new("black", [4, 7]) 
    @board << Bishop.new("black", [5, 7]) 
    @board << Knight.new("black", [6, 7]) 
    @board << Rook.new("black", [7, 7]) 
    [*0..7].each { |x| @board << Pawn.new("black", [x, 6]) }

    [*0..7].each { |x| @board << Pawn.new("white", [x, 1]) }
    @board << Rook.new("white", [0, 0]) 
    @board << Knight.new("white", [1, 0]) 
    @board << Bishop.new("white", [2, 0]) 
    @board << King.new("white", [3, 0]) 
    @board << Queen.new("white", [4, 0]) 
    @board << Bishop.new("white", [5, 0]) 
    @board << Knight.new("white", [6, 0]) 
    @board << Rook.new("white", [7, 0]) 
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
# p game.board
game.board

