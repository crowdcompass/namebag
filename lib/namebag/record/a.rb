class Namebag::Record::A < Namebag::Record

  def initialize(zone, name, data = nil)
    @zone = zone
    if data.nil?
      @name = @zone.name + "."
      @data = name
    elsif data.kind_of?(String)
      super(zone, resolve_name(name), data)
    else
      @name = resolve_name(name)
      @data = build_data(data)
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
