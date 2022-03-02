class Carrier
  attr_reader :code, :delivery_promise

  def initialize(code, delivery_promise)
    @code = code
    @delivery_promise = delivery_promise
  end
end
