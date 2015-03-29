# STRETCH: have "pick a move" filter for all legal choices player can make at that time.
# TODO: refactor: turn message passing variable assignment/method calling/argument names.2


# TODO: fix valid moves formatting
# TODO: Only allow user to pick move from valid move array, not any square.
# TODO: critical: fix turn method when empty square is called



# require "byebug"
require_relative "Board.rb"

class Game
  attr_reader :board, :players
  def initialize(board = Board.new, view = View.new)
    @board = board
    @view = view
    @players = ["white", "black"]
    # col in the sense of display
    @col_hash = {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7
    }
  end

  def play
    # stalemate, king capture, and checkmate should fire game_over
    while !game_over?
      players.each do |player|
        # clear screen
        puts display_board
        turn(player)
      end
    end
    # end
  end

  # TODO: refactor this disasterous mess of variable assignment and message passing
  def turn(player)
    # "whites turn"
    @view.turn_message(player)
    # white, move which piece?
    @view.choose_piece(player)
    # is user input valid?
    if valid_pick?(@view.choice)
      #
      location = input_to_coord(@view.choice)
      # choose piece
      piece = @board.find_piece(location)
      # find valid moves
      # might be missing an input here?
      moves = @board.valid_move(piece)
      p moves
      # display valid moves and ask player for choice
      @view.display_valid_moves(player, piece.name, moves)
      # player picks a move
      move_choice = input_to_coord(@view.pick_move(player, @view.choice))
      p move_choice


      # if invalid_move_choice(move_choice)
      #   @view.pick_again(player)


      # else
      # end

      # check for bad user input/a pick that isn't in the moves array.
      # valid_move_choice?(moves, move_choice)
      # if it was a capture, remove captured piece and display capture message, else move onto next turn.
      if @board.piece_captured?(piece, move_choice)
        @board.capture_piece(move_choice)
        # @view.display_capture_move(player, player, piece, captured_piece, choice, move_move)
        @board.move(piece, move_choice)
      else
        @board.move(piece, move_choice)
        # end turn
      end
    else
      @view.pick_again(player)
      location = input_to_coord(@view.choice)
      piece = @board.find_piece(location)
    end
    puts "end of turn"
    # find_piece and return valid_moves 2d array
    # @view.piece_chosen_message(player, piece, moves)
  end

  def invalid_move_choice(move_choice, moves)
    moves.include?(input_to_coord(move_choice))
  end

  def valid_pick?(user_input)
    @board.board_values.has_key?(user_input)
  end

  def input_to_coord(user_input)
    @board.board_values[user_input]
  end

  def coord_to_string(output)

  end

  # def valid_move_choice?(moves, input)
  #   moves.include?(input)
  # end

  # TODO: reconcile this with move method in board!
  # Currently not inputing old_pos anywhere.
  # maybe use "choice?
  def move_piece(new_pos,piece)
    @board.move(new_pos,piece)
  end

  def display_board
    @board.format
  end

  # checks for king taken, stalemate, or checkmate
  def game_over?
    (king_taken? || stalemate? || checkmate?)
  end

  def king_taken?
    false
  end

  def stalemate?
    false
  end

  def checkmate?
    false
  end

end




class View
  attr_reader :choice

  def turn_message(player)
    message(player_turn_message(player))
  end

  def choose_piece(player)
    message(choose_piece_message(player))
    @choice = user_input
  end

  # pick_move gets sent to game and @move gets sent to "move_piece"
  def pick_move(player, choice)
    message(pick_move_message(player, choice))
    @move = user_input
  end
  # if user picks invalid square
  def pick_again(player)
    message(choose_again_message(player))
    @choice = user_input
  end

  def display_valid_moves(player, piece, moves)
    message(piece_chosen_message(player, piece, moves))
  end

  def display_player_move(player)
    message(player_move_message(player, piece, move))
  end

  def display_capture_move(player)
    message(capture_message)
  end

  def display_game_over(player)
    message(game_over_message(player))
  end

  def display_capture_message(player, player2, piece, captured_piece, choice, move)
  end

  # Messages to console

  def player_turn_message(player)
    "#{player}'s turn"
  end

  def choose_piece_message(player)
    "#{player}, which piece do you want to move? ex: a5, e8"
  end

  def piece_chosen_message(player, piece, moves)
    "moves for #{player}'s #{piece}" +": " + moves.join(" ")
  end
  # move gets sent to board
  def player_move_message(player, piece, move)
    "ok, #{player}'s #{piece} #{choice} to move to #{move}"
  end

  def pick_move_message(player, choice)
    "#{player}, move #{choice} where?"
  end

  def capture_message(player, player2, piece, captured_piece, choice, move)
    "#{player}'s #{piece} {choice} captures #{player2}'s #{captured_piece} #{move}"
  end

  def choose_again_message(player)
    "#{player}, please choose a valid square"
  end

  def game_over_message(player)
    "#{player} wins!"
  end

  # siphon methods for prompts and inputs
  def user_input
    gets.chomp
  end

  def message(str)
    puts str
  end
end


G = Game.new()

#p G.input_to_int("c4")
# p G.valid_pick?("c4")
# p G.bad_input("c52829")
# p G.valid_pick?("f5")

puts G.play
