class Namebag::Record::GENERIC < Namebag::Record

  def initialize(zone, type, name, data = nil)
    super(zone, name, data)
    @type = type
  end

  def type
    @type
  end

end
