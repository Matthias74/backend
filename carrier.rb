class Carrier
  attr_reader :code, :delivery_promise, :saturday_deliveries

  def initialize(code, delivery_promise, saturday_deliveries = nil)
    @code = code
    @delivery_promise = delivery_promise
    @saturday_deliveries = saturday_deliveries
  end
end
