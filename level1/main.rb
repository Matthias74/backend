require "json"
require_relative "../eta_builder"

data = JSON.parse(File.read('./level1/data/input.json'))
EtaBuilder.new(data).compute!
