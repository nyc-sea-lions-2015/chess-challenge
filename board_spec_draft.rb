describe 'Board' do

  let (:board) {Board.new}

  it 'is initialized with an empty 8x8 board' do
    expect (board.width).to equal(8)
    expect (board.height).to equal(8)
    expect (board.empty?).to equal(true)
  end

  it 'has a clear method that clears all pieces from board' do
    board.clear
    expect (board.empty?).to equal(true)
  end

  it 'has a start method that sets the board with 32 pieces in correct orientation'

  end









end
