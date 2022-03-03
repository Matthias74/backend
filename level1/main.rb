require "json"
require_relative "../eta_builder"
require_relative "../input_builder/from_json"

EtaBuilder.new(
  InputBuilder::FromJson.new("./level1/data/input.json"),
  "level1_expected_output"
).compute!
