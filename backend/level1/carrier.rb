class Carrier
  attr_reader :code, :delivery_promise
  @@instances = []
  def initialize(code, delivery_promise)
    @code = code
    @delivery_promise = delivery_promise
    @@instances << self
  end

  def self.all
    @@instances
  end
end
