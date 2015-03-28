
require_relative 'chess_model.rb'


game = Board.new
game.set_up_board
game.to_s

def get_value(chosen_piece) #user input string
  conversion = {
  "a" => 0,
  "b" => 1,
  "c" => 2,
  "d" => 3,
  "e" => 4,
  "f" => 5,
  "g" => 6,
  "h" => 7}
  coordinate = [conversion[chosen_piece[0]],chosen_piece[1].to_i - 1]
end

puts "white's turn"
puts "white, your move?"
chosen_piece = gets.chomp.downcase #d2
x = get_value(chosen_piece)
p game.coordinate_to_object(x)



  # puts "moves for" #white pawn d2: d3, d4
  # puts "white, move d2 where?"
  # chosen_move = gets.chomp.downcase
  # puts "Ok, whites pawn d2 to d4."




