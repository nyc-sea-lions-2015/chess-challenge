require_relative 'chess_model.rb'
require "byebug"


players = ["white", "black"]
game = Board.new
game.set_up_board


def reset_screen!
  print "\e[2J"
  print "\e[H"
end

def get_value(chosen_piece)
  conversion = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h"=> 7}
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
    piece = game.coordinate_to_object(coord)
    moves = game.check_move_helper(piece)
    game.valid_moves
    # byebug
    p moves
    puts "Moves are #{moves}"
    puts "Which move would you like?"
    chosen_space = gets.chomp.downcase
  end
end




