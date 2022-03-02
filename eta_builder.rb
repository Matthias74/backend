require_relative "carrier"
require_relative "package_eta_builder"

class ShipupEtaBuilderException < StandardError; end

class EtaBuilder
  attr_reader :input, :output_name
  attr_accessor :carriers

  def initialize(input, output_name)
    @input = input
    @carriers = nil
    @output_name = output_name
  end

  def compute!
    check_input_consistency
    build_carriers
    deliveries = [].tap do |data|
      input["packages"].each do |package|
        data << PackageEtaBuilder.new(package, find_carrier(package["carrier"])).compute!
      end
    end

    puts JSON.dump({ deliveries: deliveries})

    # File.write("#{output_name}.json", JSON.dump({ deliveries: deliveries}))
  end

  private

  def check_input_consistency
    errors = []
    errors.push("carriers") if input["carriers"].nil? || input["carriers"].empty?
    errors.push("packages") if input["packages"].nil? || input["packages"].empty?
    raise ShipupEtaBuilderException.new "Some data is missing: #{errors.join(", ")}" unless errors.empty?
  end

  def build_carriers
    @carriers = input["carriers"].map do |carrier|
      Carrier.new(carrier["code"], carrier["delivery_promise"], carrier["saturday_deliveries"])
    end
  end

  def find_carrier(code)
    @carriers.find { |carrier| carrier.code == code }
  end
end
