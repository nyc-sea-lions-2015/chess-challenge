
<<<<<<< HEAD

# TODO: fix valid moves formatting
# TODO: Only allow user to pick move from valid move array, not any square.
# TODO: critical: fix turn method when empty square is called
=======
# STRETCH: allow for undo
# Stretch: allow for forfeit/end game if user types "forfeit"/"quit"
# TODO: refactor turn logic.
# SHINY: show taken pieces along right side
# SHINY: clear screen after bad input
>>>>>>> chupa_master


# if user.input == "Quit"
# abort("Quitting Game")


# require "byebug"
require_relative "Board.rb"

class Game
  attr_reader :board, :players
  def initialize(board = Board.new, view = View.new)
    @board = board
    @view = view
    @players = ["white", "black"]
  end


  def play
    while game_over? == false
      players.each do |player|
<<<<<<< HEAD
        # clear screen
        puts display_board
=======

        clear_and_display

>>>>>>> chupa_master
        turn(player)
      end
    end
  end

  private

  # TODO: refactor this mess!
  def turn(player)
    # "white/black's turn"
    @view.turn_message(player)
<<<<<<< HEAD
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
      moves_string = moves.map {|move| coord_to_string(move)} #converts coordinates to letter_num
      # display valid moves and ask player for choice
      @view.display_valid_moves(player, piece.name, moves_string)
      # player picks a move
      move_choice = input_to_coord(@view.pick_move(player, @view.choice))



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
=======

    begin #if a piece is blocked, ask player for input again
      begin #keeps asking a player which piece they want to move until they choose a piece they control
        @view.choose_piece(player)
      end until valid_pick?(@view.choice, player)
      piece = @board.find_piece(string_to_coord(@view.choice))
      moves = coord_to_string(@board.valid_move(piece))
    end while piece_blocked?(moves, piece)
    # displays valid moves and ask player for choice
    @view.display_valid_moves(player, piece.name, moves)
    begin   # player picks a move
      player_choice = @view.pick_move(player, @view.choice)
    end until valid_move_choice?(player_choice, moves)

    #TODO: refactor to capture_piece method
    # checks for piece capture
    if @board.piece_captured?(piece, string_to_coord(player_choice))
      @board.capture_piece(string_to_coord(player_choice))
      @view.display_capture_message(player, other_player(player), piece.name, @view.choice, @board.captured.last.name, player_choice)
      @board.move(piece, string_to_coord(player_choice))
      sleep(1.1)
    else
      @board.move(piece, string_to_coord(player_choice))
>>>>>>> chupa_master
    end
  end

<<<<<<< HEAD
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
    col_letter = (output[1] + 97).chr
    row_number = (output[0]+1).to_s
    string = col_letter + row_number
    string

  end

  # def valid_move_choice?(moves, input)
  #   moves.include?(input)
  # end

  # TODO: reconcile this with move method in board!
  # Currently not inputing old_pos anywhere.
  # maybe use "choice?
=======
  def capture_piece
    # refactor capture piece, display message, and move into here.
  end

  def valid_move_choice?(player_choice, moves)
    moves.include?(player_choice)
  end

  # Is the user picking a square on the board occupied by their piece?
  def valid_pick?(user_input, player)
    coord = string_to_coord(user_input)
    return false if coord == nil
    return true if (@board.board_values.has_key?(user_input) && @board.board[coord[0]][coord[1]].color == player)
  end

  # does that piece have any moves?
  def piece_blocked?(moves, piece)
    if moves.empty?
      puts "no valid moves for #{piece.name}"
      return true
    else
      return false
    end
  end

  def coord_to_string(moves)
    moves.map! do |coord|
      coord = @board.board_values.key(coord)
    end
    return moves
  end

>>>>>>> chupa_master
  def move_piece(new_pos,piece)
    @board.move(new_pos,piece)
  end

<<<<<<< HEAD
  def display_board
    @board.format
  end

=======
>>>>>>> chupa_master
  # checks for king taken, stalemate, or checkmate
  def game_over?
    @board.game_over
    # (king_taken? || stalemate? || checkmate?)
  end

  # utility methods
  def clear_and_display
    @view.clear_and_display(@board.format)
  end

  def coord_to_string(moves)
    moves.map! do |coord|
      coord = @board.board_values.key(coord)
    end
    return moves
  end

  def string_to_coord(user_input)
    # byebug
    @board.board_values[user_input]
  end

  def other_player(current_player)
    other_player = @players.select{|player| player != current_player}
    other_player[0]
  end
end

class View
  attr_reader :choice

  def initialize
    @whitespace = "     "
  end

  def clear_and_display(board)
    puts "\e[H\e[2J"
    puts display_board(board)
  end

  def display_board(board)
    puts board
  end

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

  def display_game_over(player)
    message(game_over_message(player))
  end

  def display_capture_message(player, player2, piece, starting_location, captured_piece, player_choice)
    message(capture_message(player, player2, piece, starting_location, captured_piece, player_choice))
  end

  # Messages to console
  def player_turn_message(player)
    puts
    "                #{player}'s turn"
  end

  def choose_piece_message(player)
    puts
    "#{@whitespace}choose your piece by grid. (ex: a5)"
  end

  def piece_chosen_message(player, piece, moves)
<<<<<<< HEAD
    "moves for #{player}'s #{piece}" +": " + moves.join(" ")
=======
    "#{@whitespace}moves for #{player}'s #{piece}" +": " + moves.join(", ")

>>>>>>> chupa_master
  end
  # move gets sent to board
  def player_move_message(player, piece, move)
    "#{@whitespace}ok, #{player}'s #{piece} #{choice} to move to #{move}"
  end

  def pick_move_message(player, choice)
    "#{@whitespace}#{player}, move #{choice} where?"
  end

  def capture_message(player, player2, piece, starting_location, captured_piece, move)
    "#{player}'s #{piece} #{starting_location} captures #{player2}'s #{captured_piece} #{move}"
  end

  def choose_again_message(player)
    "#{@whitespace}#{player}, please choose a valid square"
  end

  def game_over_message(player)
    "#{player} wins"
  end

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
