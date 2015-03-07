class Piece
  attr_reader :state
  def initialize(location, state, move_pattern, board, args={}) # pass board in as argument
    # use current @board so that pieces are aware of board methods
    @board = board
    @location = location
    @state = state
    @move_pattern = move_pattern
    @capture_pattern = args.fetch(:capture_pattern, move_pattern)
    @can_jump = args.fetch(:can_jump, false)
    @can_reverse = args.fetch(:can_reverse, true)
  end

  def valid_move?(row,col)
    @move_pattern == [@location[0] - row, @location[1] - col].map { |el| el.abs}
  end
# board move may return to/call update_board, place_on_cell, and/or remove
  def move(row,col)
    if valid_move?(row,col)
      if @board.cell_empty?(row,col)
        @location = [row,col]
        #@board.update_board
        #@board.place_on_cell(row,col)
      elsif victim_capturable?(row,col)
        @location = [row,col]
        #@board.remove(row,col)
        #@board.update_board
      end
    end
  end

  def victim_capturable?(victim_state)
    @state != victim_state
  end
end

class Pawn < Piece

end

class Rook < Piece

end

class Knight < Piece

end

class Bishop < Piece

end

class Queen < Piece

end

class King < Piece

end
# test_piece = Piece.new([0,0], "black", [1,0])
# p test_piece.move(1,0)


# ----------------------------------------------------------------------------------


class Game
  attr_reader :board
  #creates new board object in initialize
  def initialize
    #needs a data structure to hold player_1 and player_2
  end
  #prints board after every move
  #to_s expects the board object to have a #board attr_reader
  def to_s
  end

  #strips user input [col, row] into row, col format
  #expects a move array with 2 elements
  def strip_move(move)
    alpha = [*"a".."z"]
    alpha.map.with_index do |letter, i|
      if move[0] == letter
        move[0] = i
      end
    end
      move.reverse
  end

  #alternates player turns UNTIL game OVER
  def play
  #UNTIL check_mate?
  #player_1.turn(gets.chomp)
  #player_2.turn(gets.chomp)
  #ENDUNTIL
  end

  #checks to see if there is a check
  def check(player)
    #will return boolean
  end

  def check_mate(player)
    #will return boolean
  end

  def turn(current_location, desired_location)
    # isolate current col and row values
    current_row = current_location[0]
    current_col = current_location[1]
    #strip desired_location array:
    stripped = strip_move(desired_location) # should return a 2-element array
    #isolate desired location col and row values
    desired_row = stripped[0]
    desired_col =  stripped[1]
    # determine piece-type:
    piece = @board[current_row][current_col] #returns piece object
    # Is player's desired moved a valid move for that piece type?
    move_validity = piece.valid_move?(stripped) #returns a bool
    if move_validity == true
      if @board.cell_empty?(stripped) == false
        desired_cell_piece = @board[desired_row][desired_col]
        if victim_capturable(desired_cell_piece)
          #capture victim
        else
          #return invalid move
        end
      else
        #move piece to desired cell
      end
    else
      "invalid move"
    end
  end

# ----------------------------------------------------------------------------------


class Board
attr_accessor :board, :captured_pieces
  def initialize
    @board = [["♜""♞""♝""♛""♚""♝""♞""♜"],
    ["♟"*8],
    [" "*8],
    [" "*8],
    [" "*8],
    [" "*8],
    ["♙"*8],
    ["♖""♘""♗""♕""♔""♗""♘""♖"]].split("")
    @captured_pieces = []
  end

  def cell_empty?(y,x)
    @board[y][x] == " "
  end

  def remove(y,x)
    @board[y][x] = " "
  end

  def send_piece(y,x)
    @captured_pieces << @board[y][x]
  end

  def update_board
    #scans every piece's new location and updates on board
  end

end
