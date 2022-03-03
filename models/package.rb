module Models
  class Package
    attr_reader :id, :carrier, :shipping_date

    def initialize(id, carrier, shipping_date)
      @id = id
      @carrier = carrier
      @shipping_date = shipping_date
    end
  end
end
