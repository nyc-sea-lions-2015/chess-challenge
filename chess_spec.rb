require_relative 'chess'

describe 'let' do

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

  let(:piece) {Piece.new([5,4],'black', false)}
  let(:white_piece) {Piece.new([5,3],'white', false)}

    it "should accept (arguments, color, captured) as parameters" do
      expect (piece(arguments, color, captured)).to_not raise_error
    end

    it 'should have an arity of 2' do
      expect piece.arity.should eq 2
    end

    it "has a color method that returns the correct color of the piece" do
      expect (piece.color).to_eq(black)
      expect (white_piece.color).to_eq(white)
    end


    it "has a captured_status method that returns the correct capture status of the piece" do
      expect (piece.captured).should eq(false)
    end
  end

  # describe 'King'

  #   let(:king) {King.new([5,3], black, false)}

  #   # it 'should have an arity of 2' do
  #   #   expect (king.arity)to_eq(2)
  #   # end

  #   it "has a moves method that returns an array of all potential moves possible from its current position on an empty board." do
  #     expect (king.moves).to_eq([[4, 3], [4, 4], [5, 2], [5, 4], [6, 2], [6, 3]])
  #   end

  # describe 'Queen'

  #   let(:queen) {Queen.new([4,3], black, false)}

  #   # it 'should have an arity of 2' do
  #   #   expect (queen.arity)to_eq(2)
  #   # end

  #   it "has a moves method that returns an array of all potential moves possible from its current position on an empty board." do
  #     expect (queen.moves).to_eq([[[5, 4], [6, 5], [7, 6]], [[5, 2], [6, 1], [7, 0]], [[3, 4], [2, 5], [1, 6], [0, 7]], [[3, 2], [2, 1], [1, 0]], [[5, 3], [6, 3], [7, 3], [8, 3]], [[3, 3], [2, 3], [1, 3], [0, 3]], [[4, 4], [4, 5], [4, 6], [4, 7], [4, 8]], [[4, 2], [4, 1], [4, 0]]])
  #   end

  # describe 'Rook'

  #   let(:rook) {Rook.new([4,3], black, false)}

  #   # it 'should have an arity of 2' do
  #   #   expect (rook.arity)to_eq(2)
  #   # end

  #   it "has a moves method that returns an array of all potential moves possible from its current position on an empty board." do
  #     expect (rook.moves).to_eq([[[5, 3], [6, 3], [7, 3], [8, 3]], [[3, 3], [2, 3], [1, 3], [0, 3]], [[4, 4], [4, 5], [4, 6], [4, 7], [4, 8]], [[4, 2], [4, 1], [4, 0]]])
  #   end

  # describe ''


# end


=begin
PIECE
 - piece is initialized with a captured-status, color-status, starting position (array [row:0..7, col:0..7])
 - set attr_reader :color
 -set attr_accessor :captured (so you can change it later)
 - piece should sort the moves-array by direction so that you have separate arrays. (easier for board to stop and return out if move is blocked.)
 - the method "moves" should return an array of all potential moves possible from the current position. whether or not this move-spot is occupied or legal.
 - checks if user-generated move is included in the potential moves(array). if not, piece should know inherently that it can't move to that spot (before board is involved and filters based on other pieces' positions)


ALL PIECE TYPES
 - takes one parameter, its position, an array of coordinates


KING
 -can move one space all around from its current position





BOARD

 - initialize with an 8x8 board, no pieces on the board
 - In our view, row 0 and row 1 are black territory.
      Row 0: [[Rook.new], [Knight.new], [Bishop.new], [King.new], [Q], [B], [K], [R]]
      Row 1: array of 8 subarrays of Pawn objects
 In our view, row 6 and 7 are white territory.
      Row 6: array of 8 subarrays of Pawn objects
      Row 7: [[Rook.new], [Knight.new], [Bishop.new], [King.new], [Q], [B], [K], [R]]
 - no parameters
 - clear method: clears the board. no pieces.
 - reset method: sets a new Board.new
 - to_s method: translates the user input to useful input for us.
 - clear method: clears the board. no pieces.
 - start method: sets the board with 32 pieces in correct orientation.
 - place method: (once board is cleared) takes 2 parameters, piece-type and coordinate(array), and sets that piece-type there. (useful to check functionality of pieces)
 - remove method: board removes captured piece is piece's captured status is True.
 - moves_valid?: takes users input. call _____ method. return T/F
    - Board calls piece.moves, which returns an array of all potential moves that that piece in a certain position can make.
    - Iterate through pieces.moves(array) and check if those positions are empty and are not blocked.
        -- if the move-spot is not empty/blocked?==true, check color-status.
            -- if same color, return ......
            -- else,
 - blocked?
=end
