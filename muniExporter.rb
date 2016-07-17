#!/usr/bin/env ruby

# this

require 'rubygems'
require 'muni'
require 'sinatra'
require 'prometheus/client'
require 'prometheus/client/formats/text'
require 'rack'

set :bind, '0.0.0.0'
set :port, 5000
use Rack::Deflater, if: ->(env, status, headers, body) { body.any? && body[0].length > 512 }

# create the registry and add the muni_eta_metrics to it
prom = Prometheus::Client.registry
routes = Prometheus::Client::Gauge.new(:muni_eta_minutes, 'Minutes till next bus')
prom.register(routes)

# route, direction, stop names that I care about
stops = [
    ['N','inbound','Sunset Tunnel East Portal' ],
    ['37', 'outbound', '14th St & Castro St' ],
    ['24', 'outbound', 'Castro St & 15th St' ],
    ['24', 'inbound', 'Castro St & 15th St' ]
]

get '/metrics' do
  stops.each do |entry|
    r,d,s = entry
    soon, later = Muni::Route.find(r).direction_at(d).stop_at(s).predictions[0,2].map {|t| t.minutes.to_i}
    routes.set({route: r, direction: d, stop: s, ordinal: 'first'}, soon ) unless soon.nil?
    routes.set({route: r, direction: d, stop: s, ordinal: 'second'}, later ) unless later.nil?
  end

  Prometheus::Client::Formats::Text.marshal(prom)
end
