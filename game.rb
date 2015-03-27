# require "byebug"
require_relative "Board.rb"

class Game
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
    # rows in the sense of "display", but with indexs adjusted
    @row_hash = {

    }
    # [a5] = [5, a] [4, 0]
  end

  def play
    # if !game_over
    players.each do |player|
      turns(player)
      # clear screen
      # display_board
      # ask for user input
      #
    end
    # end
  end

  def turns(player)
    # "whites turn"
    view.turn_message(player)
    # white, move which piece?

    # needs to check for valid input
    # TODO: check this logic! might need a redo or something
    if !valid_pick(view.choose_piece)
      # gets input of [x,y]
      view.pick_again
    else
      piece = board.find_piece(view.choose_piece)
    end
    # find_piece and return valid_moves 2d array
    piece_chosen_message(player, piece, moves)
  end

  # turn user input of "letter, number" into numbers for "row, col"
  # returns [x,y] array

  # TODO: Add check for letters outside of a..h!!!
  # TODO: add check for more than two strings

  def bad_input?(input)
    (input.length > 2 || input[0])
    # false if more than two chars long
    # false if first char is outside of a..h
    # false if 2nd char is NaN
  end

  def input_to_int(location)
    coordinate = []
    # reverses because board stores as row/col, but player calls col/row
    # byebug
    parse_array = location.split("")
    # byebug
    row = parse_array.first
    col = parse_array.last
    # transform letter to int
    coordinate << (col.to_i- 1)
    coordinate << @col_hash[row]
    return coordinate
  end

  # checks if user input is a single string of a letter and number
  # and is inside 8x8 grid
  # returns boolean
  def valid_pick?(location)
    @board.out_of_bounds?(input_to_int(location))
    # !(bad_input?(location) ||
  end

  def display_board
    puts @board.display
  end

end



class View

  def turn_message(player)
    message(player_turn_message)
  end

  def choose_piece
    message(choose_piece_message)
    @choice = user_input
  end

  def pick_move(player, choice)
    "#{player}, move #{choice} where?"
    @move = user_input
  end
  # if user picks invalid square
  def pick_again
    message(choose_again_message)
  end

  def display_valid_moves
    message(piece_chosen_message)
  end

  def display_player_move
    message(player_move_message)
  end

  def display_capture_move
    message(capture_message)
  end

  # Messages to console

  def player_turn_message(player)
    "#{player}'s turn"
  end

  def choose_piece_message(player)
    "#{player}, which piece do you want to move? ex: a5, e8"
  end

  def piece_chosen_message(player, piece, moves)
    "moves for #{player} #{piece}" + moves.join(" ")
  end
  # @move gets sent to board


  def player_move_message(player, piece, move)
    "ok, #{player}'s #{piece} #{choice} to move to #{move}"
  end

  def capture_message(player, player2, piece, captured_piece, choice, move)
    "#{player}'s #{piece} {choice} captures #{player2}'s #{captured_piece} #{move}"
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

G.display_board
#p G.input_to_int("c4")
p G.valid_pick?("h9")
