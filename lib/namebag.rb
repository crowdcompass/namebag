module Namebag
  class Error < StandardError
  end

  class RecordConflictError < Error
    def initialize(existing_record, new_record)
      super("New record #{new_record} conflicts with existing record #{existing_record}")
    end
  end
end

require 'namebag/parser'
require 'namebag/zone'
require 'namebag/record'

%w[a txt cname mx].each do |record_type|
  require 'namebag/record/' + record_type
end
