# board_str = board.each_with_index.map do |row,i|
# row.each_with_index.map do |col, col_i|
# if col_i == 0
# col = "A"
# else
# col = []
# end
# end
# end
WIDTH = 8

class Piece
  attr_reader :captured
  attr_accessor :color
  def initialize(arguments, color = "black", captured = false)
    @captured, @color = captured, color
    @x, @y = arguments[0], arguments[1]
    @moves = []
  end

  def captured!
    @captured = !@captured
  end

  def to_s
    "#{@color.upcase} #{self.name} moves: #{@moves.flatten(1)}"
  end
end

class King < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments, color)
    @name = "KING"
  end

  def moves
    [*-1..1].permutation(2).to_a.each do |dx,dy|
      next if dx == 0 && dy == 0
      @moves << [@x+dx, @y+dy]
    end
      @moves
  end

end

class Knight < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments)
    @name = "KNIGHT"
  end

  def moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, -1], [-2, 1]].each do |dx, dy|
      @moves << [@x+dx, @y+dy]
    end
    @moves
  end

end

class Rook < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments,)
    @moves = Array.new(4){[]}
    @name = "ROOK"
  end

  def moves
    [*@x..WIDTH-1].each_index do |dx|
      @moves[0] << [@x+(dx+1), @y]
    end

    1.upto(@x) {|dx| @moves[1] << [@x-dx, @y]}

    [*@y..WIDTH-1].each_index do |dy|
      @moves[2] << [@x, @y+(dy+1)]
    end

    1.upto(@y) {|dy| @moves[3] << [@x, @y-dy]}
    return @moves
  end

end

class Bishop < Piece
  attr_reader
  def initialize(arguments)
    super(arguments, color)
    @name = "BISHOP"
  end

  def moves
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    empty = [[@x, @y]]
    array_temp = Array.new
    i = 0
    arr.each do |dx, dy|
      empty.each do |cx, cy|
        WIDTH.times do |num|
          cx += dx
          cy += dy
          if cx > WIDTH-1 || cx < 0 || cy > WIDTH-1 || cy < 0
            @moves << array_temp.compact unless array_temp.empty?
            array_temp.clear
            next
          end
          array_temp << [cx, cy]
        end
      end
    end
    @moves
  end

end

class Queen < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments)
    @name = "QUEEN"
  end

  def moves
    arr1 = Bishop.new([@x, @y]).moves
    arr2 = Rook.new([@x, @y]).moves
    @moves = arr1+arr2
  end

end

class Pawn < Piece
  def initialize(arguments, capture = false, status = false)
    super(arguments)
    @status = status
    @capture = capture
  end

  def moves
    @moves << [@x, @y+2] if @status
    @moves << [@x+1, @y]
    capture? if @capture
  end

  def capture?
    @moves << [@x+1, @y+1]
    @moves << [@x-1, @y+1]
  end

end

pawn = Pawn.new([5,3])
pawn.moves
puts pawn

# bishop = Bishop.new([5,3])
# bishop.moves
# puts bishop

# rook = Rook.new([5,3])
# rook.moves
# puts rook
puts
queen = Queen.new([5,3])
queen.moves
puts queen

