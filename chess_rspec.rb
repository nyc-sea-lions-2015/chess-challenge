require_relative 'chess'

describe ChessBoard do
  let(:board) { ChessBoard.new }

  describe "ChessBoard" do
    describe "#initialize" do
       it "is an instance of ChessBoard class" do
        expect(board.instance_of?(ChessBoard)).to eq(true)
       end
    end

   describe "#select_piece" do
      it "returns piece type" do
        expect(board.select_piece([4,4])).to be_a Array
      end
    end
  end


end


describe "King" do
  
  describe "#initialize" do
     it "is an instance of King class" do
      king_1 = King.new("black", [4,4])
      expect(king_1.instance_of?(King)).to eq(true)
     end
  end

  describe "#movement" do
     it "takes in the board and returns an array" do
      board = ChessBoard.new
      king_1 = King.new("black", [4,4])
      board.board[4][4] = king_1
      expect(board.board[4][4].movement(board.board)).to be_an_instance_of(Array)
     end
  end
end

describe "Queen" do
  
  describe "#initialize" do
     it "is an instance of Queen class" do
      queen_1 = Queen.new("black", [4,4])
      expect(queen_1.instance_of?(Queen)).to eq(true)
     end
  end

  describe "#movement" do
     it "takes in the board and returns an array" do
      board = ChessBoard.new
      queen_1 = Queen.new("black", [4,4])
      board.board[4][4] = queen_1
      expect(board.board[4][4].movement(board.board)).to be_an_instance_of(Array)
     end
  end
end

describe "Rook" do
  
  describe "#initialize" do
     it "is an instance of Rook class" do
      rook_1 = Rook.new("black", [4,4])
      expect(rook_1.instance_of?(Rook)).to eq(true)
     end
  end

  describe "#movement" do
     it "takes in the board and returns an array" do
      board = ChessBoard.new
      rook_1 = Rook.new("black", [4,4])
      board.board[4][4] = rook_1
      expect(board.board[4][4].movement(board.board)).to be_an_instance_of(Array)
     end
  end
end

describe "Bishop" do
  
  describe "#initialize" do
     it "is an instance of Bishop class" do
      bishop_1 = Bishop.new("black", [4,4])
      expect(bishop_1.instance_of?(Bishop)).to eq(true)
     end
  end

  describe "#movement" do
     it "takes in the board and returns an array" do
      board = ChessBoard.new
      bishop_1 = Bishop.new("black", [4,4])
      board.board[4][4] = bishop_1
      expect(board.board[4][4].movement(board.board)).to be_an_instance_of(Array)
     end
  end
end

describe "Knight" do
  
  describe "#initialize" do
     it "is an instance of Knight class" do
      knight_1 = Knight.new("black", [4,4])
      expect(knight_1.instance_of?(Knight)).to eq(true)
     end
  end

  describe "#movement" do
     it "takes in the board and returns an array" do
      board = ChessBoard.new
      knight_1 = Knight.new("black", [4,4])
      board.board[4][4] = knight_1
      expect(board.board[4][4].movement(board.board)).to be_an_instance_of(Array)
     end
  end
end


describe "Pawn" do
  
  describe "#initialize" do
     it "is an instance of Pawn class" do
      pawn_1 = Pawn.new("black", [4,4])
      expect(pawn_1.instance_of?(Pawn)).to eq(true)
     end
  end

  describe "#movement" do
     it "takes in the board and returns an array" do
      board = ChessBoard.new
      pawn_1 = Pawn.new("black", [4,4])
      board.board[4][4] = pawn_1
      expect(board.board[4][4].movement(board.board)).to be_an_instance_of(Array)
     end
  end
end







