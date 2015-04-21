require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      session_cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
      if session_cookie
        @cookie_data = JSON.parse(session_cookie.value)
      else
        @cookie_data = {}
      end
    end

    def [](key)
      @cookie_data[key]
    end

    def []=(key, val)
      @cookie_data[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      session_cookie = WEBrick::Cookie.new("_rails_lite_app", @cookie_data.to_json)
      res.cookies << session_cookie
    end
  end
end
