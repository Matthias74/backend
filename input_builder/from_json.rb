require "json"
require_relative "../models/package"
require_relative "../models/carrier"
require_relative "../interfaces/input_builder"

module InputBuilder
  class FromJson
    include Interfaces::InputBuilder
    attr_reader :file, :input, :packages, :carriers

    def initialize(file)
      @file = file
      @input = build_input
      @packages = build_packages
      @carriers = build_carriers
    end

    def find_carrier_for(package)
      @carriers.find { |carrier| carrier.code == package.carrier }
    end

    private

    def build_input
      JSON.parse(File.read(file))
    end

    def build_packages
      input["packages"].map do |package|
        Models::Package.new(package["id"], package["carrier"], package["shipping_date"])
      end
    end

    def build_carriers
      input["carriers"].map do |carrier|
        Models::Carrier.new(carrier["code"], carrier["delivery_promise"], carrier["saturday_deliveries"])
      end
    end
  end
end
