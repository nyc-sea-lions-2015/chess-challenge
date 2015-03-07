class Game
  def initialize()
    @board = Board.new.start.to_s
    @finished = false
  end

  def translate(turn)
    current = turn.chars
    return [LETTER[current[0]],8-[current[1].to_i]]
  end

  def translate_back(turns)
    turns.map do |coor_set|
      coor_set.map do |x,y|
        [LETTER.key(x),y].join
      end
    end
  end

  def start_game
    unless @finished
      puts "White player's turn"
      puts "White, what's your move? #{turn = gets.chomp}"
      turn = translate(turn)
      @board.move_valid(turn)
    end
    unless @finished
      puts "Black player's turn"
      turn2 = gets.chomp
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
