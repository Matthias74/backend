require "json"
require_relative "../eta_builder"
require_relative "../input_builder/from_json"

EtaBuilder.new(
  InputBuilder::FromJson.new("./level2/data/input.json"),
  "level2_expected_output"
).compute!
