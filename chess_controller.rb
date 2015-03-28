require_relative 'chess_model.rb'
require "byebug"


players = ["white", "black"]
game = Board.new
game.set_up_board


def reset_screen!
  print "\e[2J"
  print "\e[H"
end

@v2m_conversion = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h"=> 7}
@m2v_conversion = @v2m_conversion.invert

def v2m_coord_converter(view_coord)
  [view_coord[1].to_i - 1, @v2m_conversion[view_coord[0]]]
end

def m2v_coord_converter(model_coord_array)
  model_coord_array.map do |model_coord|
    [@m2v_conversion[model_coord[1]], model_coord[0] + 1].join("")
  end.join(", ")
end


moves = ""
while !game.check_mate? do
  players.each do |player|
    reset_screen!
    puts game.to_s
    # model_coord = ""
    # view_coord = ""
    # move_coord = ""
    model_coord, view_coord, move_coord, piece, moves = ""
    loop do
      puts "#{player}'s turn"
      puts "#{player}, which piece would you like to move?"
      view_coord = gets.chomp.downcase
      model_coord = v2m_coord_converter(view_coord)
      if game.valid_spot?(model_coord, player)
        piece = game.coordinate_to_object(model_coord)
        moves = game.check_move_helper(piece)
      end
      break if !moves.empty?
      puts "Invalid selection"
    end
    loop do
      puts "Moves for #{player} #{piece.class.to_s.downcase} are #{m2v_coord_converter(moves)}"
      puts "Which move would you like?"
      move_coord = gets.chomp.downcase
      break if moves.include?(v2m_coord_converter(move_coord))
      puts "Invalid selection"
    end
    game.place(piece, v2m_coord_converter(move_coord))
  end
end

puts "Check mate!!!"




