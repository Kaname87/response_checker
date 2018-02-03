require 'response_checker'
require 'thor'

module ResponseChecker
  class CLI < Thor
    desc "check URI", "check response code of the URI"
    def check(request_uri)
      puts request_uri
    end
  end
end