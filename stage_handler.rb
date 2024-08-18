# frozen_string_literal: true

# The StageHandler class is an abstract base class for handling different stages of a mission.
# It uses the Chain of Responsibility pattern to delegate the handling to the next handler in the chain.
class StageHandler
  # @!attribute [rw] next_handler
  #   @return [StageHandler, nil] the next handler in the chain
  attr_accessor :next_handler

  # Handles the mission execution process.
  # If the current stage processes the mission successfully, it delegates the handling to the next handler.
  # Otherwise, it delegates the handling to the current state's handle_mission method.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  def handle(mission_execution)
    if process(mission_execution)
      next_handler&.handle(mission_execution)
    else
      mission_execution.current_state.handle_mission(mission_execution)
    end
  end

  # Processes the mission execution for the current stage.
  # This method must be implemented by subclasses to define specific behavior for each stage.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @raise [NotImplementedError] if the method is not implemented in the subclass
  def process(mission_execution)
    raise NotImplementedError, 'Subclasses must implement the process method'
  end
end
