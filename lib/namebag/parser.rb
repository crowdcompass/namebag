require 'namebag'
require 'namebag/zone'

class Namebag::Parser

  class TopParser < BasicObject
    def initialize(parser, &blk)
      @parser = parser
      instance_eval &blk
    end

    def zone(name, &blk)
      ZoneParser.new(@parser, name, &blk)
    end
  end

  class ZoneParser < BasicObject
    def initialize(parser, name, &blk)
      @zone = parser.add_zone name
      instance_eval &blk
    end

    def method_missing(m, *args)
      record m, *args
    end

    def record(m, *args)
      @zone.add_record m, *args
    end

    def ip(ip_addr, *names)
      if names.last.kind_of?(::Hash)
        opts = names.pop
      else
        opts = {}
      end
      names.each do |name|
        a name, ip_addr
        if opts[:wildcards]
          cname "*.#{name}", "#{name}.#{@zone.name}."
        end
      end
    end
  end

  attr_reader :zones

  def initialize
    @zones = []
  end

  def parse(&blk)
    TopParser.new(self, &blk)
  end
    
  def read_file(filename)
    parse do
      Kernel.eval(File.read(filename), Kernel.binding)
    end
  end

  def add_zone(name)
    z   = @zones.detect {|zone| zone.name == name } 
    z ||= Namebag::Zone.new(name).tap{|zo| @zones << zo}
    z
  end

end
