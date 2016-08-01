class Runner
  attr_reader :bot

  def get_input
    pos = gets.split.map {|i| i.to_i}
    board = Array.new(5)

    (0...5).each do |i|
      board[i] = gets.strip
    end
    @bot ||= Bot.new(Position.new(*pos), Board.from_array(board))
  end

  def run
    while(get_input) do 
      puts bot.next_move
    end
  end
end
