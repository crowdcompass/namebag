require 'namebag'
require 'thor'

class Namebag::NamebagCommand < Thor
  include Thor::Actions

  desc "route53_sync NAMEBAG", "Upload zones described in NAMEBAG to a Amazon Route53 account."
  method_option :authentication, type: :string, aliases: %w[--auth -a], desc: "Path to a YAML file including Route53 authentication information. Defaults to checking ~/.namebag.auth.yml. Create the file with route53_auth."
  def route53_sync(namebag_file)
    ps = Namebag::Parser.new
    ps.read_file namebag_file
    ps.zones.each do |zone|
      r53 = Namebag::Route53Syncer.new(zone, auth_info)
      r53.sync
    end
  end

  desc "route53_auth [AUTHFILE]", "Creates a Route53 authentication file in AUTHFILE (default is ~/.namebag.auth.yml)"
  def route53_auth(auth_file = default_auth_path)
    if File.exist?(auth_file)
      unless(yes? "#{auth_file} already exists. Do you want to overwrite it?")
        return
      end
    end

    info = {
      access_key_id: ask("Amazon AWS Access Key ID: "),
      secret_access_key: ask("Amazon AWS Secret Access Key: ")
    }
    if info.values.any?(&:empty?)
      say "Not writing out auth file.", :yellow
    else
      File.open(auth_file, "w") {|f|
        f.write info.to_yaml
      }
      say "Authentication information written out to #{auth_file}.", :green
    end
  end

  private
   
    def auth_info
      if File.exist?(auth_path)
        YAML.load(File.read(auth_path))
      else
        raise "No authentication information has been provided. Please use the route53_auth command to write an auth file or use the --authentication option to provide a path to such a file."
      end
    end

    def auth_path
      options[:authentication] || default_auth_path
    end

    def default_auth_path
      File.expand_path("~/.namebag.auth.yml")
    end

end
