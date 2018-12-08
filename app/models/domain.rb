require 'net/dns'

class Domain < ApplicationRecord
  def process_office365
    raw_dns = Resolver(name).to_s

    needle = Regexp.new(
      Regexp.escape(name) + "\\.\\s+\\d+\\s+IN\\s+\\w+\\s+([^\\s]+)", Regexp::MULTILINE
    )

    raw_dns.scan needle do |scanned|
      p scanned
    end
    p '/////////////////////////////'
    save
  end
end
