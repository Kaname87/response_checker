require 'response_checker'
require 'thor'
require 'net/http'

module ResponseChecker
  class CLI < Thor

    desc "check URI", "Check response code of the URI"
    def check(request_uri)
      # Validation before parsing the argument to URI object
      if not request_uri.is_a? String and not request_uri.is_a? URI
         puts "Invalid URI. Expected URI object or URI string, #{request_uri}"
        return
      end

      uri = URI(request_uri)

      # Validation of URI protocol
      if not uri.is_a? URI::HTTP then
        puts "Invalid URI. please check if URI has a protocol info (http:// or https://), #{uri}"
        return
      end

      begin
        Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Head.new uri
          response = http.request request

          if response.is_a? Net::HTTPSuccess then
            # code, message, uri
            puts "#{response.code}, Found, #{uri}"
          else
            puts "#{response.code}, Not Found, #{uri}"
          end
        end

      rescue => e
        puts "#{e.class}, #{e.message}, #{uri}"
      end
    end

    desc "check_all FILENAME", "Check all URI in the FILENAME. The file should have one uri per line"
    def check_all(filename)
      begin
        File.open(filename).each do |line|
          # Call .chomp not to include new line
          check line.chomp
        end
      rescue => e
        puts "#{e.class}, #{e.message}"
      end
    end
  end
end