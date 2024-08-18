# frozen_string_literal: true

# The MissionSetup class is responsible for setting up the initial parameters of a mission.
# It allows for setting the mission name, displaying a default mission plan, and confirming the mission.
class MissionSetup
  # @!attribute [r] name
  #   @return [String, nil] the name of the mission
  attr_reader :name

  # Initializes a new MissionSetup instance.
  # Sets the mission name to nil.
  def initialize
    @name = nil
  end

  # Prompts the user to set the name of the mission.
  def set_name
    puts 'What is the name of this mission?'
    @name = gets.chomp
  end

  # Displays the default mission plan.
  def display_default_plan
    puts <<~PLAN
      Mission plan:
        Travel distance:  160.0 km
        Payload capacity: 50,000 kg
        Fuel capacity:    1,514,100 liters
        Burn rate:        168,240 liters/min
        Average speed:    1,500 km/h
        Random seed:      12
    PLAN
  end

  # Prompts the user to confirm the mission.
  #
  # @return [Boolean] true if the user confirms the mission, false otherwise
  def confirm_mission?
    puts 'Would you like to proceed? (Y/n)'
    gets.chomp.downcase == 'y'
  end
end
