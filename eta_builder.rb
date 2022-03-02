require_relative "carrier"
require_relative "package_eta_builder"

class ShipupEtaBuilderException < StandardError; end

class EtaBuilder
  attr_reader :input
  attr_accessor :carriers

  def initialize(input)
    @input = input
    @carriers = nil
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

    # File.write('../backend/outputs/level_1.json', JSON.dump({ deliveries: deliveries}))
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
      Carrier.new(carrier["code"], carrier["delivery_promise"])
    end
  end

  def find_carrier(code)
    @carriers.find { |carrier| carrier.code == code }
  end
end
