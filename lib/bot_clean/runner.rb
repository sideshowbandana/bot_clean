class Runner
  attr_reader :bot

  def run
    # is this a bug? I thought is was in the form "x y"
    y, x = gets.split.map {|i| i.to_i}
    board = Array.new(5)

    (0...5).each do |i|
      board[i] = gets.strip
    end
    puts Bot.new(Position.new(*pos), Board.from_array(board)).next_move
  end
end
