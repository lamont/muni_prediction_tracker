#!/usr/bin/env ruby

# want to report on
#  N inbound "Sunset Tunnel East Portal"
#  37 outbound to twin peaks
#  24 outbound to castro
#  24 inbound as well

require 'rubygems'
require 'muni'
#require 'httparty'
require 'json'
require 'prometheus/client'

stops = [
  ['N','inbound','Sunset Tunnel East Portal' ],
  ['37', 'outbound', '14th St & Castro St' ],
  ['24', 'outbound', 'Castro St & 15th St' ],
  ['24', 'inbound', 'Castro St & 15th St' ]
]

predictions = {}
prom = Prometheus::Client.registry
routes = Prometheus::Client::Gauge.new(:muni_eta_minutes, 'Minutes till next bus')

stops.each do |entry|
  r,d,s = entry
  min = Muni::Route.find(r).direction_at(d).stop_at(s).predictions.first.minutes.to_i
  predictions[entry.join('-').gsub(' ','_')] = min
  routes.set({route: r, direction: d, stop: s}, min )
end

routes.set({line: 'N', direction: 'Outbound'}, 5)
puts predictions.to_json

# response = HTTParty.post(url, body: predictions.to_json, :headers => { 'Content-Type' => 'application/json' } )

# puts response.body
# puts response.message
# puts response.code
# puts response.headers.inspect
