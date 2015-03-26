
def initialize(board, view)
  @board = Board.new(args)
  @view = View.new
  @players = ["white", "black"]
end

def play
  # if !game_over
  players.each do |player|
    turns(player)
  end
  # end
end

def turns(player)
  # if blank square/outside of board square
  view.turn_message(player)
  piece =  board.find_piece(view.choose_piece)
  moves =
  piece_chosen_message(player, piece, moves)

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
