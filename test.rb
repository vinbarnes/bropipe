# -*- coding: utf-8 -*-
require 'webrick'
require 'cgi'
require 'json'
require 'pp'

# TODO
# * create nice-looking chrome extension pop-up window
# * create "return" screen output
# * allow a special return value to open results in a new tab/window


@actions_file = '~/.bropipe/actions.yml'

# class BroPipeDaemon < WEBrick::HTTPServlet::AbstractServlet
#   def do_GET(request, response)
#     if request.query
#       queries = CGI.parse(request.query_string)
#       pp queries
#       pp cmd = actions[queries['action'][0]] % queries['href'][0]
#       system cmd
#     end
#     response.status = 200
#   end
# end

# server = WEBrick::HTTPServer.new(:Port => 7575)
# server.mount('/', BroPipeDaemon)

# %w[INT TERM].each {|sig| trap(sig) { server.shutdown } }

# server.start


def actions
  YAML::load(File.open(File.expand_path(@actions_file)))
end

def start_webrick(config = {})
  config.update(:Port => 7575)
  server = WEBrick::HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal|
    trap(signal) {server.shutdown}
  }
  server.start
end

start_webrick {|server|
  server.mount_proc('/') {|request, response|
    pp request.query
    unless request.query.empty?
      pp cmd = actions[request.query['cmd']] %
        CGI.unescape(request.query['url'])
      system cmd
    end
    response.status = 200
  }

  # return json list of action names
  server.mount_proc('/actions') {|request, response|
    response['Content-Type'] = 'application/json'
    response['Access-Control-Allow-Origin'] = '*'
    response['X-XSS-Protection'] = 0
    response.body = actions.keys.to_json
    response.status = 200
  }

  server.mount_proc('/app.js') {|request, response|
    response['Content-Type'] = 'text/javascript'
    response['Access-Control-Allow-Origin'] = '*'
    response['X-XSS-Protection'] = 0
    response.body = IO.readlines('app.js').join
    response.status = 200
  }
}
