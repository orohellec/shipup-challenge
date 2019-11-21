class Package
  attr_reader :id, :carrier, :expected_delivery, :shipping_date
  @@instances = []
  def initialize(id, carrier, shipping_date)
    @id = id
    @carrier = has_one_carrier(carrier)
    @shipping_date = shipping_date
    @expected_delivery = calcul_expected_delivery
    @@instances << self
  end

  def self.all
    @@instances
  end

  def self.deliveries_outpout
    output = {deliveries: []}
    Package.all.each do |package|
      output[:deliveries] << {
        package_id: package.id,
        expected_delivery: package.expected_delivery
      }
    end
    output
  end

  def has_one_carrier(carrier_code)
    associated_carrier = Carrier.all.select {|carrier| carrier.code == carrier_code}
    associated_carrier[0]
  end

  def calcul_expected_delivery
    shipping_date = Date.strptime(@shipping_date, "%Y-%m-%d")
    (shipping_date + 1 + self.carrier.delivery_promise).to_s
  end
end