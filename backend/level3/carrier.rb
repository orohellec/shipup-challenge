class Carrier
  attr_reader :code, :delivery_promise, :saturday_deliveries, :oversea_delay_threshold
  @@instances = []
  def initialize(code, delivery_promise, saturday_deliveries, oversea_delay_threshold)
    @code = code
    @delivery_promise = delivery_promise
    @saturday_deliveries = saturday_deliveries
    @oversea_delay_threshold = oversea_delay_threshold
    @@instances << self
  end

  def self.all
    @@instances
  end
end
