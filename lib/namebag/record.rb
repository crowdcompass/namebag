class Namebag::Record

  attr_reader :name
  attr_reader :value

  def initialize(zone, name, value = nil)
    @zone = zone
    @name = name
    @value = value
  end

  def ==(other)
    [type, name, value] == [other.type, other.name, other.value]
  end

  def inspect
    "#<#{self.class.name} #{name} #{value}>"
  end

  def conflicts_with?(other)
    false
  end

  def type
    self.class.name.split("::").last
  end

end
