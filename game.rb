WIDTH = 8
LETTER = {"A" => 0,
            "B" => 1,
            "C" => 2,
            "D" => 3,
            "E" => 4,
            "F" => 5,
            "G" => 6,
            "H" => 7 }

class Game
  def initialize()
    @board = Board.new
    @board.start
    puts @board
    @finished = false
  end

  def translate(turn)
    current = turn.chars
    return 8-current[1].to_i, LETTER[current[0]]
  end

  def translate_back(turns)
    turns.map do |x, y|
        [LETTER.key(y),8-x].join
    end
  end

  def start_game
    unless @finished
      puts "White player's turn"
      puts "White, what's your move? #{turn = gets.chomp}"
      turn = translate(turn)
      p turn
      puts "Select from your possible moves: #{translate_back(@board.move_valid(turn)).join(" ")}"
      puts "Your piece has moved to #{move_to = gets.chomp}"
      move_to = translate(move_to)
      p move_to
      @board.place_piece(turn, move_to)
      puts @board

    end
    unless @finished
      puts "Black player's turn"
      puts "Black, what's your move? #{turn2 = gets.chomp}"
      turn2 = translate(turn2)
      p turn2
      puts "Select from your possible moves: #{translate_back(@board.move_valid(turn)).join(" ")}"
      puts "Your piece has moved to #{move_to = gets.chomp}"
      move_to = translate(move_to)
      p move_to
      @board.place_piece(turn2, move_to)
      puts @board
    end
  end





  def finished?
    if @board.remove.any?(King)
      @finished = true
    end
  end

  def game_over
    removed_kings = []
    if @finished
      removed_kings = @board.remove.select do |piece|
        piece.class == King
      end
    end
    puts "#{removed_kings.first.color.capitalize} player loses!!!"
  end
end

#=====================================
class Board
  def initialize
    @board = Array.new(WIDTH) {WIDTH.times.map{[]}}
    @removed = []
    @poss_moves = []
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

  def move_valid(coordinate)
    @poss_moves.clear
    square = @board[coordinate[0]][coordinate[1]]
    # p square
    if square.empty?
      puts "This is empty!"
    else
      piece = square.first
    end
    piece.moves.each do |coordinate_set|
      coordinate_set.each do |x,y|
        if !@board[x][y].empty?
          if piece.color != @board[x][y][0].color
            @poss_moves << [x, y]
            break
          else
            break
          end
        end
        @poss_moves << [x, y] if @board[x][y].empty?
      end
    end
    @poss_moves
  end

  # def make_move(piece)
  #   piece => find possible moves (give coordinates to user)
  #   they will give us coordinate they want to move to
  #   => place piece (piece, coordinate)
  #   move the piece to cooresponding coordinate
  def place_piece(current_coord,new_coord)

    piece = @board[current_coord[0]][current_coord[1]].first
    piece.x = new_coord[1]
    piece.y = new_coord[0]
    p piece
    puts "#{current_coord[0]} #{current_coord[1]}"
    # @board.map.with_index do |row,row_i|
    #   if row_i == current_coord[0]
    #     row.map.with_index do |square,square_i|
    #       if square_i == (current_coord[1])
    #         square.delete_at(square_i)
    #       end
    #     end
    #   end
    # end
    @board[new_coord[1]][new_coord[0]] = [piece]

    @board
    # @board[new_coord[0]][new_coord[1]]<< piece if @board[new_coord[0]][new_coord[1]] == "- "
  end


  def remove

  end

  def to_s
    @board.each_with_index.map do |row, i|
      # puts "#{8-i} #{row}"
      print "#{8-i}  "
      row.each_with_index do |square, square_i|
        if square.empty?
          print "_ "
          next
        end
        print "#{square.first.class.to_s == "Knight" ? "N" : square.first.class.to_s[0]} " if square.first.color == "black"
        print "#{square.first.class.to_s == "Knight" ? "n" : square.first.class.to_s[0].downcase} " if square.first.color == "white"
      end
      puts
    end#.join(" \n")
    "   " + [*"a".."h"].join(" ")
  end
end


class Piece
  attr_reader :captured
  attr_accessor :color, :x, :y

  def initialize(arguments, color = "black", captured = false)
    @captured, @color = captured, color
    @x, @y = arguments[0], arguments[1]
    @moves = []
  end

  def remove_nil
    @moves.each do |x|
      @moves.delete(x) if x.empty?
    end
  end

  def captured!
    @captured = !@captured
  end

  def to_s
    "#{@color.upcase} #{(self.color == "black" ? self.name : self.name.downcase)} moves: #{@moves.flatten(1)}"
  end
end

class King < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments)
    @name = "KING"
  end

  def moves
    [*-1..1].permutation(2).to_a.each do |dx,dy|
      next if dx == 0 && dy == 0
      @moves << [[@x+dx, @y+dy]] unless @x+dx > WIDTH-1 || @x+dx < 0 || @y+dy > WIDTH-1 || @y+dy < 0
    end
    remove_nil
      @moves.uniq
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
      @moves << [[@x+dx, @y+dy]] unless @x+dx > WIDTH-1 || @x+dx < 0 || @y+dy > WIDTH-1 || @y+dy < 0
    end
    remove_nil
    @moves
  end

end

class Rook < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments)
    @moves = Array.new(4){[]}
    @name = "ROOK"
  end

  def moves
    [*@x..WIDTH-1].each_index do |dx|
      @moves[0] << [@x+(dx+1), @y] unless @x+(dx+1) > WIDTH-1 || @x+(dx+1) < 0
    end

    1.upto(@x) {|dx| @moves[1] << [@x-dx, @y] unless @x-dx > WIDTH-1 || @x-dx < 0}

    [*@y..WIDTH-1].each_index do |dy|
      @moves[2] << [@x, @y+(dy+1)] unless @y+(dy+1) > WIDTH-1 || @y+(dy+1) < 0
    end

    1.upto(@y) {|dy| @moves[3] << [@x, @y-dy] unless @y-dy > WIDTH-1 || @y-dy < 0}

    remove_nil
    return @moves
  end

end

class Bishop < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments)
    moves
    @name = "BISHOP"
  end

  def moves
    arr = [1, 1, -1, -1].permutation(2).to_a.uniq
    empty = [[@x, @y]]
    array_temp = Array.new

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
    remove_nil
    @moves
  end

end

class Queen < Piece
  attr_reader :name
  def initialize(arguments)
    super(arguments)
    name = "QUEEN"
  end

  def moves
    cx = @x
    cy = @y
    arr1 = Bishop.new([@x, @y]).moves
    arr2 = Rook.new([@x, @y]).moves
    @moves = arr1 + arr2
    remove_nil
    return @moves.uniq
  end

end

class Pawn < Piece #white pieces need to be able to go "up" only (each piece has its own one direction)
  attr_reader :name
  def initialize(arguments, capture = false, status = true)
    super(arguments)
    @status = status
    @capture = capture
    moves
    name = "PAWN"
  end

  def made_move
    @status = false
  end

  def moves
    @moves.clear
    if @color == "white"
      @moves << [[@x-2, @y]] if @status
      @moves << [[@x-1, @y]]
    end
    if @color == "black"
      @moves << [[@x+2, @y]] if @status
      @moves << [[@x+1, @y]]
    end
    capture? if @capture
    remove_nil
    return @moves.uniq
  end

  def capture?
    if color == "white"
      @moves << [[@x+1, @y-1]]
      @moves << [[@x-1, @y-1]]
    else
      @moves << [[@x+1, @y+1]]
      @moves << [[@x-1, @y+1]]
    end
  end

end


game = Game.new
game.start_game
