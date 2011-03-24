require 'namebag'

class Namebag::Zone

  attr_reader :name
  attr_reader :records

  def initialize(name)
    @name = name
    @records = []
  end

  def add_record(*args)
    if args.length == 1 and args.first.kind_of?(Namebag::Record)
      add_real_record(args.first)
    else
      add_real_record(create_record(*args))
    end
  end

  def fqdn
    if name =~ /\.$/
      name
    else
      name + "."
    end
  end

  def to_zonefile
    Namebag::ZonefileBuilder.new(self).to_zonefile
  end

  private

    def create_record(*args)
      type, *nargs = *args
      resolve_record_type(type).new(self, *nargs)
    end

    def resolve_record_type(type)
      Namebag::Record.const_get(type.upcase)
    end

    def add_real_record(record)
      if oldrec = detect_existing(record)
        oldrec.update(record)
      elsif badrec = detect_conflict(record)
        raise Namebag::RecordConflictError, badrec, record
      else
        @records << record
      end
    end

    def detect_existing(record)
      @records.detect{|r|
        r == record
      }
    end

    def detect_conflict(record)
      @records.detect{|existingrec|
        existingrec.conflicts_with?(record)
      }
    end

end
