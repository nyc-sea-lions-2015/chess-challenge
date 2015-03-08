describe 'Board' do

  let (:board) {Board.new}
  let (:piece) {Piece.new([5,3],'white,false')}

  it 'is initialized with an empty 8x8 board' do
    expect (board.width).to_eq(8)
    expect (board.height).to_eq(8)
    expect (board.empty?).to_eq(true)
  end

  it 'has a clear method that clears all pieces from board' do
    board.clear
    expect (board.empty?).to_eq(true)
  end

  it 'has a start method that sets the board with 32 pieces in correct orientation' do
    expect (board.start).to_eq....
  end

  it 'has a reset method that sets a new board' do
    expect (board.reset).to_eq.....
  end

  it 'has a to_s method that translates the user input' do
    expect (board.to_s).to_eq...
  end

  it 'has a remove method that removes a captured piece if piece\'s remove status is True' do
    expect (board.remove).to_eq...
  end

  it 'has a moves_valid? method ' do
  end









end
