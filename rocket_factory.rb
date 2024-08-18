# frozen_string_literal: true

require_relative 'rocket_builder'

# The RocketFactory class provides a factory method for creating Rocket objects using the RocketBuilder.
class RocketFactory
  # Builds and returns a new Rocket instance with predefined attributes.
  #
  # @return [Rocket] a new Rocket instance
  def self.build_rocket
    RocketBuilder.new
                 .with_destination_distance(160)
                 .with_fuel_capacity(1_514_100)
                 .with_burn_rate(168_233)
                 .with_payload_capacity(50_000)
                 .with_average_speed(1500)
                 .build
  end
end
