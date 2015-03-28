require_relative 'chess_model.rb'


players = ["white", "black"]
game = Board.new
game.set_up_board

def clear_screen!
  print "\e[2J"
end

def move_to_home!
  print "\e[H"
end

def reset_screen!
  clear_screen!
  move_to_home!
end

def get_value(chosen_piece)
  conversion = { "a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5,"g" => 6,"h" => 7}
  [chosen_piece[1].to_i - 1, conversion[chosen_piece[0]]]
end
moves = ""
loop do
  players.each do |player|
    reset_screen!
    puts game.to_s
    coord = ""
    loop do
      puts "#{player}'s turn"
      puts "#{player}, which piece would you like to move?"
      chosen_piece = gets.chomp.downcase
      coord = get_value(chosen_piece)
      break if game.valid_spot?(coord, player)
      puts "Invalid selection"
    end
    moves = game.coordinate_to_object(coord)
    puts "Moves are #{moves}"
    puts "Which move would you like?"
    chosen_space = gets.chomp.downcase
  end
end





#   puts "white's turn"
#   puts "white, your move?"
#   chosen_piece = gets.chomp.downcase #d2
#   coords = get_value(chosen_piece)
#   p game.coordinate_to_object(coords)



#   # puts "moves for" #white pawn d2: d3, d4
#   # puts "white, move d2 where?"
#   # chosen_move = gets.chomp.downcase
#   # puts "Ok, whites pawn d2 to d4."




