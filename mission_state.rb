# frozen_string_literal: true

# The MissionState class serves as an abstract base class for handling different states of a mission.
# Subclasses must implement the handle_mission method to define specific behavior for each state.
class MissionState
  # Handles the mission execution process.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @raise [NotImplementedError] if the method is not implemented in the subclass
  def handle_mission(mission_execution)
    raise NotImplementedError, 'Subclasses must implement the handle_mission method'
  end
end
