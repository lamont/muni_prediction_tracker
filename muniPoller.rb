#!/bin/env ruby

# want to report on
#  N inbound "Sunset Tunnel East Portal"
#  37 outbound to twin peaks
#  24 outbound to castro

require 'rubygems'
require 'muni'

stops = {
  'N' => { dir: 'inbound', stop: 'Sunset Tunnel East Portal' },
  '37' => { dir: 'outbound', stop: '14th St & Castro St' },
  '24' => { dir: 'outbound', stop: 'Castro St & 15th St' }
}

stops.each do |route, details|
  puts route + ' ' + details[:dir] + ' in ' +
    Muni::Route.find(route).direction_at(details[:dir]).stop_at(details[:stop]).predictions.first.minutes
end
