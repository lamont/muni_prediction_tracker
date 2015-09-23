#!/bin/env ruby

require 'rubygems'
require 'muni'

# want to report on
#  N inbound
#  37 outbound to twin peaks
#  24 outbound to castro

#allRoutes = Muni::Route.find(:all)
#puts "found #{allRoutes.length} routes"

the_N = Muni::Route.find('N')

# array of all stops
# the_N.directions.first.stops.map { |s| s.title }

puts "N inbound in #{the_N.inbound.stop_at("Sunset Tunnel East Portal").predictions.first.minutes} minutes"