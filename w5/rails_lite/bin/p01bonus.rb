require 'webrick'
require_relative '../lib/phase6/controller_base'
require 'pry-byebug'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class MyController < Phase6::ControllerBase
  def go
    session["count"] ||= 0
    session["count"] += 1

    # flash[:errors] = %w[BrokenCar BrokenBus BrokenPhone BrokenWatch] if
    #   session["count"] % 3 == 0

    if session["count"] % 3 == 0
      flash.now[:errors] = %w[BrokenCar BrokenBus BrokenPhone BrokenWatch]
    end
    render :flash
  end

  def go_now
    render :flash
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  MyController.new(req, res).go
end

server.mount_proc('/flash_now') do |req, res|
  MyController.new(req, res).go_now
end

trap('INT') { server.shutdown }
server.start
