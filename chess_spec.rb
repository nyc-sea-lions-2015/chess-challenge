require_relative 'game'
require_relative 'Board'

describe Game do
  let(:game1) {Game.new}

  describe "initialize" do
    it "initializes a Board clas" do
      expect(game1.board).to be_a Board

    end
      it "initializes a View clas" do
      expect(game1.view).to be_a View

    end
  end

  # describe "play" do
  #   it "plays a game until game over" do
  #     expect{game1.play}.to eq
  #     game_over
  #   end
  # end

  describe "turns" do
       it "expects 1 argument" do
      expect(Game.instance_method(:turns).arity).to eq 1
    end
  end

  describe "display_board" do
    it "displays the board of chess icons" do
      expect(game1.display_board[0][0]).to eq " ♜ "
    end
  end
end


describe View do
  let(:view1) {View.new}
  player="white"
  piece = "piece"
  moves = "a3"
  move = "a2"
  choice = "a2"
  player2 = "black"
  captured_piece = "rook"
  describe "turn_message" do
    it "give's the player's turn message" do
      expect(view1.player_turn_message(player)).to eq "white's turn"
    end
  end

  describe "choose_piece" do
    it "give's the player's choose piece message" do
      expect(view1.choose_piece_message(player)).to eq  "white, which piece do you want to move? ex: a5, e8"
    end
  end

  describe "piece_chosen_message" do
    it "give's the player's valid moves based on the move piece they chose" do
      expect(view1.piece_chosen_message(player,piece,choice, moves)).to eq "moves for white's pawn a2: a3 "
    end
  end

  describe "pick_move" do
    it "returns the pick move prompt" do
      expect(view1.pick_move(player,choice)).to eq "white, move a2 where?"
    end
  end

  # describe "pick_again" do
  #   it "returns the pick again prompt" do
  #     expect(view1.pick_again).to eq ??
  #   end
  # end

  describe "display_player_move" do
    it "displays the player's chosen move" do
      expect(view1.player_move_message(player,piece,move)).to eq  "ok, white's pawn a2 to move to a3 "
    end
  end

  describe "display_capture_move" do
    it "displays the capture message" do
      expect(view1.capture_message(player,player2,piece,captured_piece,choice)).to eq "white's pawn a2 captures black's rook a3"
    end
  end
end

describe Board do

  # describe move(old_pos, new_pos, piece)
  let(:board1) {Board.new}
  pawn2 = board1[6][2]
  describe "initializes" do
    it "initializes with an array of length 8" do
      expect(board1.board.length).to eq 8
    end

    it "initializes with a board display array containing chess character icons" do
      expect(board1.display[0]).to eq [" ♜ " , " ♞ ",  " ♝ ", " ♛ ",  " ♚ ",  " ♝ ",  " ♞ ",  " ♜ "]
    end

    # describe "valid_moves" do
    #   it "returns a string beginning with [" do
    #     expect(pawn2.valid_moves).to eq "["
    #   end
    # end

    describe "move(current, destination, piece)" do
      it "moves a piece from its current position into the specified position" do
        board1.move([7,7], [3,4], board1.board[7][7])
        expect(board1[3][4].name).to eq "rook"
      end
    end

    describe "all_pieces_same_color(player)" do
      it "selects all of the pieces of a given color" do
        player = "white"
        expect(boar1.all_pieces_same_color(player).length).to eq 16
      end
    end

    desribe "check?(player)"
     let(:board2){Board.new}
     board2.board.each_with_index.map do |row, row_index|
      row.each_with_index.map do |col, col_index|
        board2.board[row_index][col_index] = nil
      end
    end
    board2.board[0][3] = King.new
    board2.board[0][4] = Queen.new
    board2.board[0][4].color = "black"
    it "returns true if the current player puts the other team's king in check"
    expect(board2.check?("white")).to_eq true

    # describe "free_space?" do
    #   it "returns a string beginning with [" do2
    #     expect(task1.to_s[0]).to eq "["
    #   end
    # end

    # describe "move_one" do
    #   it "returns a string beginning with [" do
    #     expect(task1.to_s[0]).to eq "["
    #   end
    # end

    # describe "out_of_bounds?" do
    #   it "returns a string beginning with [" do
    #     expect(task1.to_s[0]).to eq "["
    #   end
    # end

    # describe "find_piece" do
    #   it "returns a string beginning with [" do
    #     expect(task1.to_s[0]).to eq "["
    #   end
    # end

    # describe "string_to_index" do
    #   it "returns a string beginning with [" do
    #     expect(task1.to_s[0]).to eq "["
    #   end
    # end
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
        expect(pawn1.moves).to eq [[0,1]]
      end
      describe "capturing?"
      it "adds the up 1 over 1 diagonal move for a pawn when capturing"
      pawn1.capturing? = true
      expect(pawn1.moves).to eq [[0,1],[1,1]]
    end
  end

  describe Rook do
    let(:rook1){Rook.new}
    describe "name" do
      it "has the name attribute 'rook'" do
        expect(rook1.name]).to eq "rook"
      end
    end
  end

  describe Bishop do
    let(:bishop1){Bishop.new}
    describe "icon" do
      it "has the icon attribute ♝" do
        expect(bishop1.icon]).to eq "♝"
      end
    end
  end

  desribe Queen do
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
        expect(king1.location]).to eq [0,4]
      end
    end
  end

  describe Knight do

  end
