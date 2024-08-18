# frozen_string_literal: true

# The RandomEvent class simulates random events that can affect a rocket's journey.
class RandomEvent
  attr_reader :random

  # Initializes a new RandomEvent instance.
  #
  # @param _seed [Integer] the seed for the random number generator (currently unused)
  def initialize(_seed)
    # @random = Random.new(seed)
    @random = Random.new
  end

  # Determines if the event should cause an abort.
  #
  # @return [Boolean] true if the event should cause an abort, false otherwise
  def should_abort?
    random.rand(3).zero?
  end

  # Determines if the event should cause an explosion.
  #
  # @return [Boolean] true if the event should cause an explosion, false otherwise
  def should_explode?
    random.rand(5).zero?
  end

  # Calculates a random distance and time based on the rocket's destination distance and average speed.
  #
  # @param rocket [Rocket] the rocket object containing destination distance and average speed
  # @return [Array<Float>] an array containing the random distance and time
  def random_distance_and_time(rocket)
    random_factor = random.rand(2)
    distance = (rocket.destination_distance * random_factor).round(2)
    time = (rocket.average_speed * random_factor).round(2)

    puts "RandomEvent: random_distance_and_time = [#{distance}, #{time}]"
    [distance, time]
  end
end
