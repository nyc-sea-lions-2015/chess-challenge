# require_relative 'game'
require_relative 'Board'

# describe Game do
#   let(:game1) {Game.new}

#   describe "initialize" do
#     it "initializes a Board clas" do
#       expect(game1.board).to be_a Board

#     end
#       it "initializes a View clas" do
#       expect(game1.view).to be_a View

#     end
#   end



#   describe "turns" do
#        it "expects 1 argument" do
#       expect(Game.instance_method(:turns).arity).to eq 1
#     end
#   end


# end


# describe View do
#   let(:view1) {View.new}
#   player="white"
#   piece = "piece"
#   moves = "a3"
#   move = "a2"
#   choice = "a2"
#   player2 = "black"
#   captured_piece = "rook"
#   describe "turn_message" do
#     it "give's the player's turn message" do
#       expect(view1.player_turn_message(player)).to eq "white's turn"
#     end
#   end

#   describe "choose_piece" do
#     it "give's the player's choose piece message" do
#       expect(view1.choose_piece_message(player)).to eq  "white, which piece do you want to move? ex: a5, e8"
#     end
#   end

#   describe "piece_chosen_message" do
#     it "give's the player's valid moves based on the move piece they chose" do
#       expect(view1.piece_chosen_message(player,piece,choice, moves)).to eq "moves for white's pawn a2: a3 "
#     end
#   end

#   describe "pick_move" do
#     it "returns the pick move prompt" do
#       expect(view1.pick_move(player,choice)).to eq "white, move a2 where?"
#     end
#   end


#   describe "display_player_move" do
#     it "displays the player's chosen move" do
#       expect(view1.player_move_message(player,piece,move)).to eq  "ok, white's pawn a2 to move to a3 "
#     end
#   end

#   describe "display_capture_move" do
#     it "displays the capture message" do
#       expect(view1.capture_message(player,player2,piece,captured_piece,choice)).to eq "white's pawn a2 captures black's rook a3"
#     end
#   end
# end


describe Board do

  # describe move(old_pos, new_pos, piece)
  let(:board1) {Board.new}
  let(:board2){Board.new}
  let(:pawn2) {board1.board[6][2]}

  describe "initializes" do
    it "initializes with an array of length 8" do
      expect(board1.board.length).to eq 8
    end

    it "initializes with a board display array containing chess character icons" do
      expect(board1.format).to eq [" ♜ " , " ♞ ",  " ♝ ", " ♛ ",  " ♚ ",  " ♝ ",  " ♞ ",  " ♜ "]
    end
  end

  describe "valid_move(piece)" do
    it "returns an array of the valid destinations for a given piece"  do
      expect(valid_move(pawn2)).to eq [[5,2],[4,2]]
    end
  end

  describe "move(piece, destination)" do
    it "moves a piece from its current position into the specified position" do
      board1.move(board1.board[6][0], [5,0])
      expect(board1.board[5][0].name).to eq "pawn"
    end
  end

  describe "all_pieces_same_color(player)" do
    it "selects all of the pieces of a given color" do
      player = "white"
      expect(board1.all_pieces_same_color(player).length).to eq 16
    end
  end


  describe "check?(player)" do
    it "returns true if the current player puts the other team's king in check" do
    board2.board.each_with_index.map do |row, row_index|
      row.each_with_index.map do |col, col_index|
        board2.board[row_index][col_index] = nil
      end
      end
       board2.board[0][3] = King.new([0,3])
      board2.board[0][4] = Queen.new([0,4], "black")
      expect(board2.check?("white")).to_eq true
    end
  end

  describe "checkmate" do
    it "returns false when the opponent's king is not in checkmate" do
      expect(board2.checkmate).to eq false
    end
    it "returns true when the opponent's king is in checkmate" do
      board2.board[0][5] = Rook.new([0,5], "black")
      board2.board[2][3] = Bishop.new([2,3], "black")
      expect(board2.checkmate).to eq true
    end
  end

  describe "free_space?(x,y)" do
    it "returns a a boolean value as to whether the space is empty on the board" do
      expect(board2.board.free_space?(4,4)).to eq true
    end
  end


  describe "out_of_bounds?(location)" do
    it "returns a a boolean value as to whether a given move would put the piece outside the board" do
      expect(board2.board.out_of_bounds([-1,-1])).to eq true
    end
  end

end

describe Piece do
  let(:piece1){Piece.new}
  describe "all adjacent" do
    it "has an attribute which returns an array of all 8 vector directions" do
      expect(piece.all_adjacent).to eq [[0, 1],[0, -1],[1,0],[-1,0],[1,1],[-1,1],[1,-1],[-1,-1]]
    end
  end
end

  describe Pawn do
    let(:pawn1){Pawn.new}

    describe "moves" do
      it "has a moves attribute of the basic move up 1" do
        pawn1.location = [1,0]
        expect(pawn1.moves).to eq [[0,1],[2,0]]
      end
  end
end
  describe Rook do
    let(:rook1){Rook.new}
    describe "name" do
      it "has the name attribute 'rook'" do
        expect(rook1.name).to eq "rook"
      end
    end
  end

  describe Bishop do
    let(:bishop1){Bishop.new}
    describe "icon" do
      it "has the icon attribute ♝" do
        expect(bishop1.icon).to eq "♝"
      end
    end
  end

  describe Queen do
     let(:queen1){Queen.new}
    describe "color" do
      it "has the color attribute white upon initializing" do
        expect(queen1.color).to eq "white"
      end
    end
  end

  describe King do
    let(:board5){Board.new}
     let(:king1){King.new}
    describe "location" do
      it "has the location attribute [0,4] upon initializing a board" do
        expect(king1.location).to eq [0,4]
      end
    end

end

# describe Knight do

# end
