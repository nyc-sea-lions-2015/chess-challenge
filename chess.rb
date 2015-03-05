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
      next if dx == 0 && dy == 0
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

class Bishop < Piece
  def initialize(x, y)
    @x, @y = x, y
    @moves = []
    @stable_x = @x
    @stable_y = @y
  end

  #DO A @X AND @Y.EACH FOR EACH LOOP SO YOU DONT NEED TO DO THIS REPETITIVE STUFF! YEA? COO!
  def move_LR
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    arr.each do |dx, dy|
      WIDTH.times do |num|
        @x += dx
        @y += dy
        @moves << [@x, @y] unless @x > WIDTH-1 || @x < 0 || @y > WIDTH-1 || @y < 0
      end
      return @moves
    end
    @x = @stable_x
    @y = @stable_y
  end

  def move_LR2
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    arr.each do |dx, dy|
      WIDTH.times do |num|
        @x -= dx
        @y -= dy
        @moves << [@x, @y] unless @x > WIDTH-1 || @x < 0 || @y > WIDTH-1 || @y < 0
      end
    end
    @x = @stable_x
    @y = @stable_y
    return @moves.uniq
  end

  def move_RL
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    arr.each do |dx, dy|
      WIDTH.times do |num|
        puts "loop one #{@x}, #{@y}"
        @x -= dx
        @y -= dy
        @moves << [@x, @y] unless @x > WIDTH-1 || @x < 0 || @y > WIDTH-1 || @y < 0
      end
    end
    @x = @stable_x
    @y = @stable_y
    return @moves.uniq
  end

  def move_RL2
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    arr.each do |dx, dy|
      WIDTH.times do |num|
        @x -= dx
        @y += dy
        next if @x > WIDTH-1 || @x < 0 || @y > WIDTH-1 || @y < 0
        @moves << [@x, @y]
      end
    end
    @x = @stable_x
    @y = @stable_y
    return @moves.uniq
  end

end

# king = King.new(5,3)
# p king.moves

# knight = Knight.new(5,3)
# p knight.moves

# rook = Rook.new(5,5)
# p rook.moves

bishop = Bishop.new(4,3)
bishop.move_LR
bishop.move_LR2
bishop.move_RL
p bishop.move_RL2






