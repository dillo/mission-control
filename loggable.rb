# frozen_string_literal: true

# The Loggable module provides an interface for logging mission-related information.
# Classes including this module must implement the methods defined here.
module Loggable
  # Prints the status of a specific rocket mission.
  #
  # @param rocket [Object] the rocket object whose status is to be printed
  # @param elapsed_time [Integer] the time elapsed since the mission started
  # @raise [NotImplementedError] if the method is not implemented in the subclass
  def print_mission_status(rocket, elapsed_time)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  # Prints a summary of a specific mission.
  #
  # @param mission [Object] the mission object whose summary is to be printed
  # @raise [NotImplementedError] if the method is not implemented in the subclass
  def print_mission_summary(mission)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  # Prints the status of all missions.
  #
  # @param missions [Array<Object>] an array of mission objects whose statuses are to be printed
  # @raise [NotImplementedError] if the method is not implemented in the subclass
  def print_all_missions_status(missions)
    raise NotImplementedError, 'Implement this method in a subclass'
  end
end
