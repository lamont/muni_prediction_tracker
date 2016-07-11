#!/usr/bin/env ruby

# want to report on
#  N inbound "Sunset Tunnel East Portal"
#  37 outbound to twin peaks
#  24 outbound to castro
#  24 inbound as well

require 'rubygems'
require 'muni'
require 'httparty'
require 'json'


stops = [
  ['N','inbound','Sunset Tunnel East Portal' ],
  ['37', 'outbound', '14th St & Castro St' ],
  ['24', 'outbound', 'Castro St & 15th St' ],
  ['24', 'inbound', 'Castro St & 15th St' ]
]

predictions = {}

stops.each do |entry|
  r,d,s = entry
  predictions[entry.join('-').gsub(' ','_')] =
      Muni::Route.find(r).direction_at(d).stop_at(s).predictions.first.minutes.to_i
end

puts predictions.to_json

# response = HTTParty.post(url, body: predictions.to_json, :headers => { 'Content-Type' => 'application/json' } )

# puts response.body
# puts response.message
# puts response.code
# puts response.headers.inspect
