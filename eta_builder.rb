require_relative "package_eta_builder"

class ShipupEtaBuilderException < StandardError; end

class EtaBuilder
  attr_reader :input, :output_name

  def initialize(input, output_name)
    @input = input
    @output_name = output_name
  end

  def compute!
    check_input_consistency
    deliveries = [].tap do |data|
      input.packages.each do |package|
        data << PackageEtaBuilder.new(package, input.find_carrier_for(package)).compute!
      end
    end

    puts JSON.dump({ deliveries: deliveries})
    # puts "Find me also in json file here: #{output_name}.json"
    # File.write("#{output_name}.json", JSON.dump({ deliveries: deliveries}))
  end

  private

  def check_input_consistency
    errors = []
    errors.push("carriers") if input.carriers.nil? || input.carriers.empty?
    errors.push("packages") if input.packages.nil? || input.packages.empty?
    raise ShipupEtaBuilderException.new "Some data is missing: #{errors.join(", ")}" unless errors.empty?
  end
end
