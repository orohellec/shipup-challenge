class Package
  attr_reader :id, :carrier, :expected_delivery, :oversea_delay
  @@instances = []
  @@country_distances = {}

  def initialize(id, carrier, shipping_date, origin_country, destination_country)
    @id = id
    @carrier = has_one_carrier(carrier)
    @shipping_date = shipping_date
    @oversea_delay = calcul_oversea_delay(origin_country, destination_country)
    @expected_delivery = calcul_expected_delivery(@oversea_delay)
    @@instances << self
  end

  def self.country_distances(distances)
    @@country_distances = distances
  end

  def self.all
    @@instances
  end

  def self.deliveries_outpout
    output = {deliveries: []}
    Package.all.each do |package|
      output[:deliveries] << {
        package_id: package.id,
        expected_delivery: package.expected_delivery,
        oversea_delay: package.oversea_delay
      }
    end
    output
  end

  def has_one_carrier(carrier_code)
    associated_carrier = Carrier.all.select {|carrier| carrier.code == carrier_code}
    associated_carrier[0]
  end

  def calcul_oversea_delay(origin_country, destination_country)
    distance = @@country_distances[origin_country][destination_country]
    oversea_delay_threshold = self.carrier.oversea_delay_threshold
    oversea_delay = 0
    while distance >= oversea_delay_threshold
      oversea_delay += 1
      distance -= oversea_delay_threshold
    end
    oversea_delay
  end

  def calcul_expected_delivery(oversea_delay)
    shipping_date = Date.strptime(@shipping_date, "%Y-%m-%d")
      expected_delivery_date = shipping_date + 1 + self.carrier.delivery_promise + oversea_delay
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