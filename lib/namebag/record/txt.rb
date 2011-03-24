class Namebag::Record::TXT < Namebag::Record

  def initialize(*args)
    super
    unless @data
      @data = @name
      @name = nil
    end
  end

end
