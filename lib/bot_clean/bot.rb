class Bot
  attr_reader :brain
  
  class Brain
    attr_accessor :current_position, :next_target, :board, :moves, :depth
    
    def initialize(board, moves, next_target = nil)
      @board = board.clone
      @moves = moves.clone
      @depth = moves.count
      @next_target = next_target || next_targets.sort{|a,b|
        current_position.distance_to(a) <=> current_position.distance_to(b)
      }.first
      
    end

    def current_position
      @current_position ||= moves.inject(&:+)
    end

    def previous_position
      @previous_position ||= moves[0..-2].inject(&:+)
    end

    def next_targets
      board.dirty_positions.map{|dirty|
           [current_position.distance_to(dirty), dirty]
      }.sort{|a,b| a[0] <=> b[0] }.map(&:last)
    end

    def clean_target
      board.clean(current_position)
    end

    def current_cell
      board.cell_at(current_position)
    end

    def visit_cell
      moves << next_move if next_move
      board.update_bot(current_position, previous_position) do 
        if current_cell.dirty?
          moves << Board::CLEAN_MOVE
          clean_target
        end
      end
      current_cell.visited = true
    end

    def next_moves
      moves = board.available_moves(current_position).select{|move|
        good_move?(move[0])
      }
      moves
    end

    def next_move
      next_moves.first[0] if next_moves.first
    end

    def good_move?(move)
      future_position = current_position + move
      future_position.distance_to(next_target) < current_position.distance_to(next_target)
    end
  end

  def initialize(position, board)
    brain = Brain.new(board, [Position.new(*position)])
    determine_path(brain)
  end
  
  def next_move
    # the first element is our starting point. The next element is our
    # next best move
    Board.get_move(@best_path[1])
  end

  def determine_path(brain)
    board = brain.board

    # stop if we're already above a better answer
    if @min_moves && brain.depth >= @min_moves
      return
    end

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
    

    if target = brain.next_targets.first
      new_brain = Brain.new(board, brain.moves, target)
      
      determine_path(new_brain)
    end

    nil
  end
end
