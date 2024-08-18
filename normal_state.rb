# frozen_string_literal: true

require_relative 'mission_state'

# The NormalState class represents a state in which the mission is proceeding normally.
# It inherits from the MissionState class and implements the handle_mission method.
class NormalState < MissionState
  # Handles the mission execution process by launching the rocket and printing the mission summary.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  def handle_mission(mission_execution)
    mission_execution.launch_rocket
    mission_execution.log.print_mission_summary(mission_execution)
  end
end
