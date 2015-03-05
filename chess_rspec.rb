require_relative 'chess'

describe ChessBoard do
  let(:board) { ChessBoard.new }

  describe "ChessBoard" do

    describe "#initialize" do
       it "is an instance of ChessBoard class" do
        expect(board.instance_of?(ChessBoard)).to eq(true)
       end
    end

    # describe "#valid_move?" do
    #   it "returns true for a valid move" do
    #     expect(board.valid_move?(PUT COORDINATES HERE)).to eq(true)
    #   end
    # end

    #  describe "#select_piece" do
    #   it "returns piece type" do
    #     expect(board.select_piece(PUT COORDINATES HERE)).to be_a Array
    #   end
    # end

  end
end





