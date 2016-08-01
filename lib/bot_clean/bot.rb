class Bot
  attr_reader :brain
  
  class Brain
    attr_accessor :current_position, :next_target, :board, :moves,
            :depth
    
    def initialize(board, moves, depth)
      @board = board.clone
      @moves = moves.clone
      @depth = depth
    end

    def current_position
      @current_position ||= moves.inject(&:+)
    end

    def previous_position
      @previous_position ||= moves[0..-2].inject(&:+)
    end

    def next_target
      return @next_target if @next_target
      if weighted_targets = board.dirty_positions.map{|dirty|
           [dirty - current_position, dirty]
         }.sort{|a,b| a[0] <=> b[0] }.first
        @next_target = weighted_targets.last
      end
    end

    def clean_target
      @next_target = nil
      board.clean(current_position)
    end

    def current_cell
      board.cell_at(current_position)
    end

    def visit_cell
      if current_cell.dirty?
        moves << Board::CLEAN_MOVE
        clean_target
      end
      current_cell.visited = true
      board.update_bot(current_position, previous_position)
    end

    def next_moves
      board.available_moves(current_position).sort{|a,b|
        move_value(a[0]) <=>  move_value(b[0]) 
      }
    end

    def next_move
      next_moves.first[0]
    end

    def move_value(move)
      diff = next_target - (current_position + move)
      diff.x.abs + diff.y.abs
    end
  end

  def initialize(position, board)
    brain = Brain.new(board, [Position.new(*position)], 0)
    determine_path(brain)
  end
  
  def next_move
    @current_move ||= 0
    Board.get_move(@best_path[@current_move += 1])
  end

  def determine_path(brain)
    board = brain.board

    current_position = brain.current_position
    previous_position = brain.previous_position

    current_cell = brain.current_cell

    brain.visit_cell
    
    if !board.dirty?
      if (@min_moves.nil? || @min_moves >= brain.depth)
        @best_path = brain.moves
        @min_moves = brain.depth
      end
      return
    end


    if board.dirty?
      determine_path(Brain.new(board, (brain.moves + [brain.next_move]), brain.depth + 1))
    end

    nil
  end

  def move_value(position)
    diff = next_target - position
    diff.x.abs + diff.y.abs
  end
end
