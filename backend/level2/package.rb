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
      expected_delivery_date = shipping_date + 1 + self.carrier.delivery_promise
      add_delivery_days = 0
      date = shipping_date
      until date > expected_delivery_date
        if !self.carrier.saturday_deliveries && date.wday == 6
          expected_delivery_date += 2
          date += 2
        elsif date.wday == 0
          expected_delivery_date += 1
          date += 1
        else
          date += 1
        end
      end
      (expected_delivery_date).to_s
  end
end