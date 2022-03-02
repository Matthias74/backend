require "json"
require_relative "../eta_builder"

data = JSON.parse(File.read('./level2/data/input.json'))
EtaBuilder.new(data, "level2_expected_output").compute!
