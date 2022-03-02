require "date"

class PackageEtaBuilder
  attr_reader :package, :carrier
  def initialize(package, carrier)
    @package = package
    @carrier = carrier
  end

  def compute!
    {
      package_id: package["id"],
      expected_delivery: build_eta
    }
  end

  private

  def build_eta
    shipping_date = Date.parse(package["shipping_date"])
    shipping_date = shipping_date.next_day(carrier.delivery_promise.to_i)
    shipping_date.strftime("%Y-%m-%d")
  end
end

