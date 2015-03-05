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
  def initialize(arguments, color="black", captured = false)
    @captured, @color = captured#, color
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
    @moves = Array.new(4){[]}
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
  def initialize(arguments)
    super(arguments)
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
  def initialize(arguments)
    super(arguments)
  end

  def moves
    arr1 = Bishop.new([@x, @y]).moves
    arr2 = Rook.new([@x, @y]).moves
    return arr1.concat(arr2)
  end
end

class Pawn < Piece
  def initialize(arguments, capture = false, status = false)
    super(arguments)
    @status = status
    @capture = capture
  end

  def moves
    @moves << [@x, @y+2] if status
    @moves << [@x+1, @y]
    capture? if @capture
  end

  def capture?
    @moves << [@x+1, @y+1], [@x-1, @y+1]
  end

end

king = King.new([5,3])
p king.moves

knight = Knight.new([5,3])
p knight.moves
puts "rook:"
rook = Rook.new([4,3])
p rook.moves

puts "bishop:"
bishop = Bishop.new([4,3])
p bishop.moves

puts "queen:"
queen = Queen.new([4,3])
p queen.moves





