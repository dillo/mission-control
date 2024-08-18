# frozen_string_literal: true

require_relative 'game_builder'

# The Main class serves as the entry point for the application.
# It initializes and runs the game using the GameBuilder.
class Main
  # Initializes and runs the game.
  def self.run
    game = GameBuilder.new.build
    game.run
  end
end

# Run the application
Main.run
