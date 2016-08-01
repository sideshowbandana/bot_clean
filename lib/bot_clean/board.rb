class Board
  attr_reader :state, :dirty_positions, :dirty_num

  CLEAN = "CLEAN"

  UP = "UP"
  DOWN = "DOWN"
  LEFT = "LEFT"
  RIGHT = "RIGHT"

  UP_MOVE = Position.new(0, -1)
  DOWN_MOVE = Position.new(0, 1)
  LEFT_MOVE = Position.new(-1, 0)
  RIGHT_MOVE = Position.new(1, 0)
  CLEAN_MOVE = Position.new(0, 0)

  def self.from_array(board_array)
    dirty_positions = []
    state = []
    board_array.each_with_index{|row, y|
      state[y] ||= []
      row.chars.each_with_index{|c, x|
        state[y] << Cell.new(c).tap do |cell|
          if cell.dirty?
            dirty_positions << Position.new(x, y)
          end
        end
      }
    }
    self.new(dirty_positions, state)
  end

  def initialize(dirty_positions, state)
    @dirty_num = dirty_positions.count
    @dirty_positions = dirty_positions
    @state = state
  end

  def clone
    # need to clone nested arrays. By default clone only does a
    # shallow copy
    Board.new(@dirty_positions.clone, state.map{|row| row.map{|cell| cell.clone}})
  end

  def cell_at(position)
    return unless [position.x,position.y].all?{|v| (0..4).include?(v) }
    @state[position.y][position.x]
  end


  def available_moves(current_position)
    [
      UP_MOVE,
      DOWN_MOVE,
      LEFT_MOVE,
      RIGHT_MOVE
    ].map{|move|
      position = current_position + move
      if (cell = cell_at(position))# && !cell.visited?
        [move, cell]
      end
    }.compact
  end

  def update_bot(new_position, old_position=nil)
    cell_at(old_position).clean if old_position
    yield
    cell_at(new_position).place_bot
  end

  def self.get_move(position)
    case position
    when CLEAN_MOVE
      CLEAN
    when UP_MOVE
      UP
    when DOWN_MOVE
      DOWN
    when LEFT_MOVE
      LEFT
    when RIGHT_MOVE
      RIGHT
    end
  end

  def clean(position)
    cell_at(position).clean
    @dirty_positions.reject!{|p|
      p == position
    }
    @dirty_num = @dirty_positions.count
  end

  def dirty?
    @dirty_num > 0
  end

  def to_s
    inspect
  end

  def inspect
    state.map(&:inspect)
  end
end
