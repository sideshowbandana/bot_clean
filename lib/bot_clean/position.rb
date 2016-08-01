class Position < Struct.new(:x, :y)

  def +(position)
    Position.new(self.x + position.x, self.y + position.y)
  end

  def -(position)
    Position.new(self.x - position.x, self.y - position.y)
  end

  def <=>(other)
    [self.x.abs, self.y.abs] <=> [other.x.abs, other.y.abs]
  end
end
