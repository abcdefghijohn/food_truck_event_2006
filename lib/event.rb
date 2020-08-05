class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_truck_that_sell(item)
    @food_trucks.find_all do |truck|
      truck.check_stock(item) > 0
    end
  end

  def total_inventory
    @food_trucks.reduce(Hash.new{ |h,k| h[k] = {quantity: 0, food_trucks: []}}) do |collector, food_truck|
      food_truck.inventory.each do |item, amount|
        collector[item][:quantity] += amount
        collector[item][:food_trucks] << food_truck
      end
      collector
    end
  end
end
