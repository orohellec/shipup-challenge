class Carrier
  attr_reader :code, :delivery_promise, :saturday_deliveries
  @@instances = []
  def initialize(code, delivery_promise, saturday_deliveries)
    @code = code
    @delivery_promise = delivery_promise
    @saturday_deliveries = saturday_deliveries
    @@instances << self
  end

  def self.all
    @@instances
  end
end
