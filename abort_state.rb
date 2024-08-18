# frozen_string_literal: true

require_relative 'mission_state'

# The AbortState class represents a state in which the mission is aborted.
# It inherits from the MissionState class and implements the handle_mission method.
class AbortState < MissionState
  # Handles the mission execution when an abort condition is met.
  #
  # This method checks if the mission has already been aborted. If not, it aborts the mission.
  #
  # @param mission_execution [MissionExecution] the mission execution object that manages the mission state.
  #
  # @return [void]
  def handle_mission(mission_execution)
    return if mission_execution.abort_count.positive?

    mission_execution.abort_mission
  end
end
