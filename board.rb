class Board
  def initialize
    @board = Array.new(8) {8.times.map{[]}}
  end

  def clear
    @board.clear
  end

  def start

  end

  def place(piece, position)

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
