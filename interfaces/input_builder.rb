module Interfaces
  module InputBuilder
    def build_input
      raise "build_input should be impemented"
    end

    def build_packages
      raise "build_packages method should be impemented"
    end

    def build_carriers
      raise "build_carriers method should be implemented"
    end
  end
end
