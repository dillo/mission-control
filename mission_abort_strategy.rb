# frozen_string_literal: true

# The MissionAbortStrategy class is an abstract base class for defining different abort strategies for a mission.
# Subclasses must implement the handle_abort method to define specific abort behavior.
class MissionAbortStrategy
  # Handles the abort process for a mission.
  # This method must be implemented by subclasses to define specific abort behavior.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @raise [NotImplementedError] if the method is not implemented in the subclass
  def handle_abort(mission_execution)
    raise NotImplementedError, 'This method should be implemented by a subclass'
  end
end
