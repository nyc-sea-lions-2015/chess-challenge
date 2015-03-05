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
  def initialize(captured = false)#,color)
    @captured, @color = captured#, color
    # @color = ... for the purpose of whether or not a piece can be captured.
  end

  def captured!
    @captured = !@captured
  end
end

class King < Piece
  def initialize(x,y)
    @x, @y = x,y
    @moves = []
  end

  def moves
    [*-1..1].permutation(2).to_a.each do |dx,dy|
      @moves << [@x+dx, @y+dy]
    end
      @moves
  end
end

class Knight < Piece
  def initialize(x, y)
    @x, @y = x, y
    @moves = []
  end

  def moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, -1], [-2, 1]].each do |dx, dy|
      @moves << [@x+dx, @y+dy]
    end
    @moves
  end
end

class Rook < Piece
  def initialize(x, y)
    @x, @y = x, y
    @moves = []
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
    @moves
  end

end

# king = King.new(5,3)
# p king.captured!

# knight = Knight.new(5,3)
# p knight.moves

rook = Rook.new(5,5)
p rook.moves






