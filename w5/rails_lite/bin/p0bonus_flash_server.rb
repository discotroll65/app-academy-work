require 'webrick'
require_relative '../lib/phase6/controller_base'
require_relative '../lib/phase6/router'

require 'pry-byebug'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html


$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

class StatusesController < Phase6::ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params[:cat_id])
    end

    render_content(statuses.to_s, "text/text")
  end
end

class Cats2Controller < Phase6::ControllerBase
  def go
    session["count"] ||= 0
    session["count"] += 1

    # flash[:errors] = %w[BrokenCar BrokenBus BrokenPhone BrokenWatch] if
    #   session["count"] % 3 == 0

    if session["count"] % 3 == 0
      flash[:errors] = %w[BrokenCar BrokenBus BrokenPhone BrokenWatch]
    end
    render :flash
  end
end

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/cats$"), Cats2Controller, :go
  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
