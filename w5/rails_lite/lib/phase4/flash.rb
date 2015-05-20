require 'json'
require 'webrick'
require 'pry-byebug'

module Phase4
  class Flash
    # find the cookie for this app
    # deserialize the cookie into a hash

    def initialize(req)
      @next_hash = {}
      our_cookie = req
        .cookies.find{|cookie| cookie.name == '_rails_lite_appflash'}
      @now_hash = our_cookie.nil? ? { } : JSON.parse(our_cookie.value)
    end

    def [](key)
      total_flash = @now_hash.merge(@next_hash)
      total_flash[key.to_s] || total_flash[key.to_sym]
    end

    def []=(key, val)
      @next_hash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_appflash', @next_hash.to_json)
    end

    def now
      @now_hash
    end

  end
end
