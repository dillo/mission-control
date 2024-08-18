# frozen_string_literal: true

require_relative 'rocket'

# The RocketBuilder class provides a builder pattern for creating Rocket objects.
class RocketBuilder
  # Initializes a new RocketBuilder instance with default values.
  def initialize
    @destination_distance = 160
    @fuel_capacity = 1_514_100
    @burn_rate = 168_233
    @payload_capacity = 50_000
    @average_speed = 1500
  end

  # Sets the destination distance for the rocket.
  #
  # @param distance [Integer] the distance to the destination
  # @return [RocketBuilder] the current instance of RocketBuilder
  def with_destination_distance(distance)
    @destination_distance = distance
    self
  end

  # Sets the fuel capacity for the rocket.
  #
  # @param fuel [Integer] the fuel capacity
  # @return [RocketBuilder] the current instance of RocketBuilder
  def with_fuel_capacity(fuel)
    @fuel_capacity = fuel
    self
  end

  # Sets the burn rate for the rocket.
  #
  # @param rate [Integer] the burn rate
  # @return [RocketBuilder] the current instance of RocketBuilder
  def with_burn_rate(rate)
    @burn_rate = rate
    self
  end

  # Sets the payload capacity for the rocket.
  #
  # @param payload [Integer] the payload capacity
  # @return [RocketBuilder] the current instance of RocketBuilder
  def with_payload_capacity(payload)
    @payload_capacity = payload
    self
  end

  # Sets the average speed for the rocket.
  #
  # @param speed [Integer] the average speed
  # @return [RocketBuilder] the current instance of RocketBuilder
  def with_average_speed(speed)
    @average_speed = speed
    self
  end

  # Builds and returns a new Rocket instance with the specified attributes.
  #
  # @return [Rocket] a new Rocket instance
  def build
    Rocket.new(
      destination_distance: @destination_distance,
      fuel_capacity: @fuel_capacity,
      burn_rate: @burn_rate,
      payload_capacity: @payload_capacity,
      average_speed: @average_speed
    )
  end
end
