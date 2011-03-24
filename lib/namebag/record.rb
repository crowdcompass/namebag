class Namebag::Record

  attr_reader :name
  attr_reader :data

  def initialize(zone, name, data = nil)
    @zone = zone
    @name = name
    @data = data
  end

  def ==(other)
    [type, name, data] == [other.type, other.name, other.data]
  end

  def inspect
    "#<#{self.class.name} #{name} #{data}>"
  end

  def conflicts_with?(other)
    false
  end

  def type
    self.class.name.split("::").last
  end

  def fqdn
    if name
      if name =~ /\.$/
        name
      else
        "#{name}.#{@zone.fqdn}"
      end
    else
      @zone.fqdn
    end
  end

end
