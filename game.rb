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
    while !game_over
      players.each do |player|
        # clear screen
        puts "\e[H\e[2J"
        display_board
        turn(player)
      end
    end
    # end
  end

  def turn(player)
    # "whites turn"
    @view.turn_message(player)
    # white, move which piece?
    @view.choose_piece(player)
    # is user input valid?
    if valid_pick?(@view.choice)
      location = input_to_int(@view.choice)
      piece = @board.find_piece(location)
    else
      @view.pick_again(player)
      location = input_to_int(@view.choice)
      piece = @board.find_piece(location)
    end
    puts "end of turn"
    # find_piece and return valid_moves 2d array
    # @view.piece_chosen_message(player, piece, moves)
  end

  # checks for bad user input before we convert to coordinates
  def bad_input?(input)
    # false if more than two chars long
    # false if first char is outside of a..h
    # false if 2nd char is NaN
    (input == nil || input.length > 2 || input[1].to_i < 0 || input[1].to_i > 8 || !(@col_hash.has_key?(input[0])))
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

  # checks if user input is a letter and number
  # and is inside 8x8 grid
  # returns boolean
  def valid_pick?(location)
    !bad_input?(location)
  end

  def display_board
    puts @board.display
  end

  def game_over?
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

  def pick_move(player, choice)
    "#{player}, move #{choice} where?"
    @move = user_input
  end
  # if user picks invalid square
  def pick_again(player)
    message(choose_again_message(player))
  end

  def display_valid_moves(player)
    message(piece_chosen_message(player))
  end

  def display_player_move(player)
    message(player_move_message(player))
  end

  def display_capture_move(player)
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

  def choose_again_message(player)
    "#{player}, please choose a valid square"
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

# G.display_board
#p G.input_to_int("c4")
# p G.valid_pick?("c4")
# p G.bad_input("c52829")
# p G.valid_pick?("f5")

G.turn(G.players[0])
