WIDTH = 8
class Board
  def initialize
    @board = Array.new(WIDTH) {WIDTH.times.map{[]}}
    @removed = []
  end

  def clear
    @board.clear
  end

  def start
    #TODO: place pawns in appropriate places
    @board.map.with_index do |row, i|
      if i== 1 || i == WIDTH -2
        row.map do |square|
          square << "PAWN"
        end
      end
      if i == 0 || i == WIDTH-1
        row.map.with_index do |square,square_i|
          if square_i == 0 || square_i == WIDTH-1
            square << "ROOK"
          elsif square_i == 1 || square_i == WIDTH-2
            square << "KNIGHT"
          elsif square_i ==2 || square_i == WIDTH-3
            square << "BISHOP"
          elsif square_i == 3
            square << "QUEEN"
          else
            square << "KING"
          end
        end
      end
    # end
    end
    @board
  end

   def remove
    #TODO: remove pieces if piece.captured == true
    #stores removed pieces in removed array.
    @board.map.with_index |row, row_i|
      row.map.with_index
    end
  end

  def to_s
    @board.each_with_index.map do |row, i|
      # puts "#{8-i} #{row}"
      puts "#{i} #{row}"

    end
    "   " + [*"a".."h"].join("   ")
  end
end

board = Board.new
# puts board
board.start
puts board
