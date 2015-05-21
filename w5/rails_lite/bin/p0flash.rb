require 'webrick'
require_relative '../lib/phase6/controller_base'
require_relative '../lib/phase6/router'
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

end

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/cats$"), MyController, :go
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  #binding.pry
  route = router.run(req, res)
end


trap('INT') { server.shutdown }
server.start
