require 'net/dns'

class Domain < ApplicationRecord
  WHITE_LIST = [
    "mail.protection.outlook.com",
    "autodiscover.outlook.com",
    "sipdir.online.lync.com",
    "webdir.online.lync.com",
    "clientconfig.microsoftonline-p.net",
    "enterpriseregister.windows.net",
    "enterpriseenrollment.manage.microsoft.com"
  ];

  def process_office365
    begin
      self.raw_dns = Net::DNS::Resolver.start(name, Net::DNS::ANY).to_s
    rescue
      begin
        self.raw_dns = Net::DNS::Resolver.start(name).to_s
      rescue
        return
      end
    end

    needle = Regexp.new(
      Regexp.escape(name) + "\\.\\s+\\d+\\s+IN\\s+\\w+\\s+([^\\s]+)", Regexp::MULTILINE
    )

    self.is_office365 = false
    self.raw_dns.scan needle do |scanned|
      WHITE_LIST.each do |string_to_check|
        if scanned[0].index(string_to_check) != nil
          self.is_office365 = true
        end
      end
    end
    self.save!
  end
end
