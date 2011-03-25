module Namebag
  class Error < StandardError
  end

  class RecordConflictError < Error
    def initialize(existing_record, new_record)
      super("New record #{new_record} conflicts with existing record #{existing_record}")
    end
  end

  autoload :Parser, 'namebag/parser'
  autoload :Zone, 'namebag/zone'
  autoload :Record, 'namebag/record'
  autoload :ZonefileBuilder, 'namebag/zonefile_builder'
  autoload :Route53Syncer, 'namebag/route53_syncer'
  autoload :NamebagCommand, 'namebag/namebag_command'

end
