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
    @board.map.with_index do |row, row_i|
      if row_i== 1 || row_i == 6
        row.map.with_index do |square, square_i|
          square << Pawn.new([row_i, square_i])
        end
      elsif row_i == 0 || row_i == WIDTH-1
        row.map.with_index do |square,square_i|
          if square_i == 0 || square_i == WIDTH-1
            square << Rook.new([row_i, square_i])
          elsif square_i == 1 || square_i == WIDTH-2
            square << Knight.new([row_i, square_i])
          elsif square_i ==2 || square_i == WIDTH-3
            square << Bishop.new([row_i, square_i])
          elsif square_i == 3
            square << Queen.new([row_i, square_i])
          else
            square << King.new([row_i, square_i])
          end
        end
      end

##changing pieces (black) to white when on rows 6 & 7

##PROBLEM: because square is in an array containing the piece, we have to use #first to access the piece itself.
# If *not* in an array, can directly access.
      if row_i == WIDTH-2 || row_i == WIDTH-1
        row.map do |square|
          square.first.color = "white"
        end
      end
    end


    @board
  end

  #  def remove
  #   #TODO: remove pieces if piece.captured == true
  #   #stores removed pieces in removed array.
  #   @board.map.with_index |row, row_i|
  #     row.map.with_index
  #   end
  # end

  def to_s
    @board.each_with_index.map do |row, i|
      # puts "#{8-i} #{row}"
      print "#{i}  "
      row.each_with_index do |square, square_i|
        next if square.empty?
        print "#{square.first.name} "
      end
      puts
    end#.join(" \n")
    "   " + [*"a".."h"].join("   ")
  end
end


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
    moves
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
    moves
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
    super(arguments)
    @moves = Array.new(4){[]}
    @name = "ROOK"
    moves
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
    moves
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
    moves
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
    moves
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


board = Board.new
# puts board
board.start
puts board.to_s
