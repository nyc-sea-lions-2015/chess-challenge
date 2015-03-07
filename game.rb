class Game
  def initialize()
    @board = Board.new.start.to_s
    @finished = false
  end

  def start_game
    unless @finished
      puts "White player's turn"
      puts "White, what's your move? #{turn = gets.chomp}"
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
