require "spec_helper"
describe Position do
  let(:position_a){ Position.new(0,0) }
  let(:position_b){ Position.new(0,1) }

  it "can add to another position" do
    expect(position_a + position_b).to eq position_b
  end
end
