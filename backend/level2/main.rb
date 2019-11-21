require 'json'
require 'date'

require './carrier.rb'
require './package.rb'

input_file = File.read('./data/input.json')
input_hash = JSON.parse(input_file)

carriers = input_hash["carriers"]
packages = input_hash["packages"]

carriers.each do |carrier|
  Carrier.new(carrier["code"], carrier["delivery_promise"], carrier["saturday_deliveries"])
end

packages.each do |package|
  Package.new(package["id"], package["carrier"], package["shipping_date"])
end

open('./data/output.json', 'w') do |f|
  f << JSON.pretty_generate(Package.deliveries_outpout)
end