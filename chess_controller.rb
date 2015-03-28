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
  coordinate = [chosen_piece[1].to_i - 1, conversion[chosen_piece[0]]]
end
  puts "white's turn"
  puts "white, your move?"
  chosen_piece = gets.chomp.downcase #d2
  coords = get_value(chosen_piece)
  p game.coordinate_to_object(coords)


  # puts "moves for" #white pawn d2: d3, d4
  # puts "white, move d2 where?"
  # chosen_move = gets.chomp.downcase
  # puts "Ok, whites pawn d2 to d4."



# @conversion = {
#   "a" => game.board[0..7].map {|col| col[0]},
#   "b" => game.board[0..7].map {|col| col[1]},
#   "c" => game.board[0..7].map {|col| col[2]},
#   "d" => game.board[0..7].map {|col| col[3]},
#   "e" => game.board[0..7].map {|col| col[4]},
#   "f" => game.board[0..7].map {|col| col[5]},
#   "g" => game.board[0..7].map {|col| col[6]},
#   "h" => game.board[0..7].map {|col| col[7]},}


# def convert
#   @conversion.each do |column|
#     if @chosen_piece[0] == column[0][0]
#       return column[0]
#     end
#   end
# end



  # grab zero from each one

# array = []
# game.board.each do |row|
#   array << row[0]
#   end
# p array


# game.board
# p a = game.board[0][3] #row,col




# knight = Knight.new(color:"black", position: [0,0])
# p game.place(knight,knight.position)
# game.to_s
# p game.knight_move(knight)
# p game.place(knight,[2,1])
# game.to_s



