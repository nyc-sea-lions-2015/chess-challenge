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
  def initialize(arguments, captured = false)
    # @captured, @color = captured#, color
    # @color = ... for the purpose of whether or not a piece can be captured.
    @x, @y = arguments[0], arguments[1]
    @moves = []
  end

  def captured!
    @captured = !@captured
  end
end

class King < Piece
  def initialize(arguments)
    super(arguments)
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
  def initialize(arguments)
    super(arguments)
  end

  def moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, -1], [-2, 1]].each do |dx, dy|
      @moves << [@x+dx, @y+dy]
    end
    @moves
  end
end

class Rook < Piece
  def initialize(arguments)
    super(arguments)
  end

  def moves
    [*@x..WIDTH-1].each_index do |dx|
      @moves << [@x+(dx+1), @y]
    end
    1.upto(@x) {|dx| @moves << [@x-dx, @y]}
    [*@y..WIDTH-1].each_index do |dy|
      @moves << [@x, @y+(dy+1)]
    end
    1.upto(@y) {|dy| @moves << [@x, @y-dy]}
    return @moves
  end

end

class Bishop < Piece
  def initialize(arguments)
    super(arguments)
  end

  def move
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    empty = [[@x, @y]]
    arr.each do |dx, dy|
      empty.each do |cx, cy|
        WIDTH.times do |num|
          cx -= dx
          cy -= dy
          @moves << [cx, cy] unless cx > WIDTH-1 || cx < 0 || cy > WIDTH-1 || cy < 0
        end
      end
    end
    return @moves
  end
end

king = King.new([5,3])
p king.moves

knight = Knight.new([5,3])
p knight.moves

rook = Rook.new([5,3])
p rook.moves

bishop = Bishop.new([4,3])
p bishop.move






