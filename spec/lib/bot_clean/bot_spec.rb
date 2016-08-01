require "spec_helper"
describe Bot do
  let(:board){
    Board.from_array(
      [
        "bd---",
        "-d---",
        "---d-",
        "---d-",
        "--d-d"
      ]
    )
  }
  let(:board2){
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
  let(:position){ Position.new(0,0) }
  let(:bot){ Bot.new(position, board) }

  it "can move right" do
    expect(bot.next_move).to eq Board::RIGHT
  end

end
