require 'logger'
require 'naws-route53-models'
require 'naws/net_http_transport'

class Namebag::Route53Syncer

  attr_reader :logger

  def initialize(zone, opts = {})
    @zone = zone
    @opts = opts
    @logger = opts[:logger] || Logger.new($stderr)
    @context = Naws::Route53::Context.new(
                :access_key_id => @opts[:access_key_id],
                :secret_access_key => @opts[:secret_access_key],
                :transport => :net_http
               )
  end

  def sync
    find_or_create_r53_zone
    @logger.info "Nameservers for #{@zone.name}: #{@r53_zone.name_servers.join(" ")}"
    find_existing_records
    @zone.records.group_by do |record|
      [record.type, record.fqdn]
    end.each do |grouping, records|
      r53_record = find_or_create_record_set(grouping, records)
      next if r53_record.nil?
      if r53_record.save
        
      else
        @logger.error "Failed to save R53 record for #{records.inspect}"
        raise
      end
    end
  end

  private

    def find_or_create_r53_zone
      @r53_zone = Naws::Route53::Models::HostedZone.all_with_context(@context).detect{|zone|
        zone.name == @zone.fqdn
      }
      @r53_zone ||= begin
        z = Naws::Route53::Models::HostedZone.new_with_context(@context, :name => @zone.fqdn, :caller_reference => Time.now.to_s)
        unless z.save
          @logger.error "Unable to save HostedZone #{@zone.name}!"
          raise
        end
        z
      end
    end

    def find_existing_records
      @record_sets = @r53_zone.record_sets
    end

    def find_or_create_record_set(grouping, records)
      record_set = @record_sets.detect{|record_set|
        [record_set.type, record_set.name] == grouping
      }
      record_set ||= begin
        Naws::Route53::Models::RecordSet.new_with_context(@context, :type => grouping[0], :name => grouping[1], :id => [@r53_zone.id, nil, nil], :ttl => 600)
      end
      if record_set.records and record_set.records.sort == records.map(&:data).sort
        @logger.info "#{grouping} already up to date, skipping."
        nil
      else
        record_set.records = records.map(&:data) 
        record_set
      end
    end

end
