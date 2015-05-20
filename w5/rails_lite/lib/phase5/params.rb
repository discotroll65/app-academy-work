require 'uri'
require 'pry-byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @req = req
      @params = route_params
      @params = @params.merge(parse_www_encoded_form(@req.query_string)) if
        @req.query_string
      @params = @params.merge(parse_www_encoded_form(@req.body)) if
        @req.body
    end

    def [](key)
      @params[key.to_s] || @params[key.to_sym]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    #body hash given as "user[address][street]=main"
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main  &  user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params_key_vals = URI.decode_www_form(www_encoded_form).to_h

      params_key_vals.inject({}) do |nested_params, (key, val)|
        nested_keys = parse_key(key)

        nested_keys.inject(nested_params) do |current_nested_param,
            inner_key|
          if inner_key == nested_keys.last
            current_nested_param[inner_key] = val
          else
            current_nested_param[inner_key] ||= {}
            current_nested_param[inner_key]
          end
        end

        nested_params
      end

    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      regex = /\]\[|\[|\]/
      key.split(regex)
    end
  end
end
