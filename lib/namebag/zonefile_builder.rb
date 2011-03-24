class Namebag::ZonefileBuilder

  def initialize(zone, opts = {})
    @zone = zone
    @opts = {}
  end

  def to_zonefile
    "".tap do |text|
      text << "$ORIGIN #{@zone.fqdn}\n" 
      @zone.records.each do |record|
        text << "#{record.fqdn}\t#{record.type}\t#{record.data}\n"
      end
    end
  end

end
