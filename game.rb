
def initialize(board, view)
  @board = Board.new(args)
  @view = View.new
  @players = ["white", "black"]
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
  # if blank square/outside of board square
  view.turn_message(player)
  piece =  board.find_piece(view.choose_piece)
  name = piece.name.downcase!
  board.recursive_move_check(piece) if name == "queen" || name == "bishop" || name == "rook"
  moves = valid_moves(piece)

  view.piece_chosen_message(player, name, moves)
  view.display_valid_moves(player, location, move) #prompts move
  view.pick_move
  view.player_move_message(player, piece, move)




  def display_board


  end

class View

  def turn_message(player)
    message(player_turn_message)
  end

  def choose_piece
    message(choose_piece_message)
    @choice = user_input
  end
 def display_valid_moves
    message(piece_chosen_message)
  end
  def pick_move(player, choice)
    "#{player}, move #{choice} where?"
    @move = user_input
  end
  # if user picks invalid square
  def pick_again
    message(choose_again_message)
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

   def player_choose_move_message(player, location, move)
    "ok, #{player}, move #{location} where?"
    user_input
  end
  def player_move_message(player, piece, move)
    "ok, #{player}'s #{piece} #{choice} #{location}to move to #{move}"
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
