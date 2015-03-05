class Board
  def initialize
    @board = Array.new(8) {8.times.map{[]}}
  end

  def clear
    @board.clear
  end

  def start
    #TODO: place pawns in appropriate places
  end

  def place(piece, position)
    #assume piece = some instance of a piece-type class
    #assume position is an array [x,y]
    piece.arguments = position
  end

  def removed

  end

  def to_s
    @board.each_with_index.map do |row, i|
      puts "#{8-i} #{row}"
    end
    "   " + [*"a".."h"].join("   ")
  end
end

board = Board.new
puts board
