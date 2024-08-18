# frozen_string_literal: true

require_relative 'mission_state'

# The ExplodeState class represents a state in which the mission has failed catastrophically.
# It inherits from the MissionState class and implements the handle_mission method.
class ExplodeState < MissionState
  # Handles the mission execution when an explosion condition is met.
  #
  # This method checks if the mission has already exploded. If not, it triggers the mission explosion.
  #
  # @param mission_execution [MissionExecution] the mission execution object that manages the mission state.
  #
  # @return [void]
  def handle_mission(mission_execution)
    return if mission_execution.explosion_count.positive?

    mission_execution.explode_mission
  end
end
