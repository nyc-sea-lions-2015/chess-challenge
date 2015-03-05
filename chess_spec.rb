require 'chess'

describe 'Board'

let(:board) {Board.new}

  it "has a width and height of 8 rows and columns" do
    expect(board.width).to_eq(8)
    expect(board.height).to_eq(8)
  end

  it "has a clear method that removes all pieces" do
    board.clear
    expect(board.pieces.empty?).to_eq(true)
  end

#   it "has 32 pieces"
describe 'Piece'

  let(:piece) {Piece.new}

    it "should accept (captured_status, color_status, starting_position) as parameters" do
      expect {piece(captured_status, color_status, starting_position)}.to_not raise_error
    end

    it "has a color method that returns the correct color of the piece" do
      expect {piece.color}.to_eq.....
    end

    it " dohas a captured_status method that returns the correct capture status of the piece" do
      expect {piece.captured_status}.to_eq(false)
    end

    it "has a moves method that returns an array of all potential moves possible from its current position on an empty board." do
      expect {piece.moves}.to_eq........
    end

    it "it sorts the moves-array by direction so that you have separate arrays" do
      expect {piece.moves}.to_eq.......
    end

end


# end


=begin
PIECE
 - piece is initialized with a captured-status, color-status, starting position (array [row:0..7, col:0..7])
 - set attr_reader :color
 -set attr_accessor :captured (so you can change it later)
 - piece should sort the moves-array by direction so that you have separate arrays. (easier for board to stop and return out if move is blocked.)
 - the method "moves" should return an array of all potential moves possible from the current position. whether or not this move-spot is occupied or legal.
 - checks if user-generated move is included in the potential moves(array). if not, piece should know inherently that it can't move to that spot (before board is involved and filters based on other pieces' positions)
 -

BOARD

 - initialize with an 8x8 board, with Piece objects in correct starting position.
 - In our view, row 0 and row 1 are black territory.
      Row 0: [[Rook.new], [Knight.new], [Bishop.new], [King.new], [Q], [B], [K], [R]]
      Row 1: array of 8 subarrays of Pawn objects
 In our view, row 6 and 7 are white territory.
      Row 6: array of 8 subarrays of Pawn objects
      Row 7: [[Rook.new], [Knight.new], [Bishop.new], [King.new], [Q], [B], [K], [R]]
 - no parameters
 - clear method: clears the board. no pieces.
 - reset method: sets a new Board.new
 - remove method: board removes captured piece is piece's captured status is True.
 - moves_valid?: takes users input. call _____ method. return T/F
    - Board calls piece.moves, which returns an array of all potential moves that that piece in a certain position can make.
    - Iterate through pieces.moves(array) and check if those positions are empty and are not blocked.
        -- if the move-spot is not empty/blocked?==true, check color-status.
            -- if same color, return ......
            -- else,
 - blocked?
=end



