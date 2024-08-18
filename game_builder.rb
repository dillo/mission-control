# frozen_string_literal: true

require_relative 'game'

# The GameBuilder class is responsible for constructing Game objects.
# It allows for the configuration of a custom log before building the game.
class GameBuilder
  # Initializes a new GameBuilder instance.
  # Sets up a default MissionLog and an empty missions array.
  def initialize
    @log = MissionLog.new
    @missions = []
  end

  # Sets a custom log for the game.
  #
  # @param log [MissionLog] the custom log to be used for the game
  # @return [GameBuilder] returns the builder instance for method chaining
  def with_log(log)
    @log = log
    self
  end

  # Builds and returns a new Game instance with the configured log.
  #
  # @return [Game] the constructed Game instance
  def build
    Game.new(log: @log)
  end
end
