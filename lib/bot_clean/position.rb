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

  def distance_to(position)
    Math.sqrt((position.x - self.x)**2 + (position.y - self.y)**2)
  end
end
