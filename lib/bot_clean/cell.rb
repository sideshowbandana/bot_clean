class Cell
  attr_accessor :visited
  DIRTY = "d"
  CLEAN = "-"
  BOT = "b"

  def initialize(state)
    @state = state
  end

  def clean
    @state = CLEAN
  end

  def place_bot
    @state = BOT
  end
  
  def dirty?
    @state == DIRTY
  end

  def visited?
    !!visited
  end

  def to_s
    @state
  end

  def inspect
    to_s
  end
end
