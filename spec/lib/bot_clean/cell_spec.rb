require "spec_helper"
describe Cell do
  let(:clean_cell){ Cell.new(Cell::CLEAN) }
  let(:bot_cell){ Cell.new(Cell::BOT) }
  let(:dirty_cell){ Cell.new(Cell::DIRTY) }

  it "knows if it's dirty" do
    expect(dirty_cell.dirty?).to eq true
    expect(bot_cell.dirty?).to eq false
    expect(clean_cell.dirty?).to eq false
  end

  it "knows if it has been visited" do
    expect{
      clean_cell.visited = true
    }.to change{
      clean_cell.visited?
    }.from(false).to(true)
  end
end
