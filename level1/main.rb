require "json"
require_relative "../eta_builder"

data = JSON.parse(File.read('./level1/data/input.json'))
EtaBuilder.new(data, "level1_expected_output").compute!
