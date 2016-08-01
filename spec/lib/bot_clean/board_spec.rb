require "spec_helper"

describe Board do
  let(:board){
    Board.from_array(
      [
        "b---d",
        "-d--d",
        "--dd-",
        "--d--",
        "----d"
      ]
    )
  }

  it "can get a cell" do
    expect(board.cell_at(Position.new(1, 1)).dirty?).to eq true
  end

  it "returns nil if the cell doesn't exist" do
    expect(board.cell_at(Position.new(-1, 0))).to eq nil
  end

  it "has available moves for a position" do
    available_moves = board.available_moves(Position.new(1,1))
    expect(available_moves.map(&:first)).to eq [
                                              Board::UP_MOVE,
                                              Board::DOWN_MOVE,
                                              Board::LEFT_MOVE,
                                              Board::RIGHT_MOVE
                                            ]

    available_moves = board.available_moves(Position.new(0,0))
    expect(available_moves.map(&:first)).to eq [
                                              Board::DOWN_MOVE,
                                              Board::RIGHT_MOVE
                                              ]
  end

  it "knows the number of dirty cells" do
    expect(board.dirty_num).to eq 7
  end

  it "decreases the dirty cells after cleaning" do
    board.clean(Position.new(1,1))
    expect(board.dirty_num).to eq 6
    expect(board.dirty_positions.count).to eq 6
  end
end
