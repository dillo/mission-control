# frozen_string_literal: true

class Rocket
  attr_reader :fuel_capacity,
              :burn_rate,
              :payload_capacity,
              :average_speed

  def initialize(fuel_capacity:, burn_rate:, payload_capacity:, average_speed:)
    @fuel_capacity = fuel_capacity || 1_514_100
    @burn_rate = burn_rate || 168_233
    @payload_capacity = payload_capacity || 50_000
    @average_speed = average_speed || 1500
  end
end
