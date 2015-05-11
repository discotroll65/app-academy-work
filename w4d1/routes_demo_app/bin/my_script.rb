require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.html'
  # query_values: {
  #    'state[capital]' => 'sacramento',
  #
  #
  #    'car[model]' => 'corolla',
  #    'car[name]' => 'pegasus',
  #    'car[color]' => 'red'
  #    }



).to_s
begin
puts RestClient.post(
  url,
  {user:
    {name: 'Gizmosucks'}
  }
  )
rescue RestClient::UnprocessableEntity => e
  # render(json: user.errors.full_messages)
end
