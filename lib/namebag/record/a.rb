class Namebag::Record::A < Namebag::Record

  def initialize(zone, name, value = nil)
    @zone = zone
    if value.nil?
      @name = @zone.name + "."
      @value = name
    elsif value.kind_of?(String)
      super(zone, resolve_name(name), value)
    else
      @name = resolve_name(name)
      @value = build_value(value)
    end
  end

  private

    def resolve_name(name)
      if name =~ /\.$/
        name
      else
        "#{name}.#{@zone.name}."
      end
    end

end
