# frozen_string_literal: true

require_relative "mission"

class Game
  attr_reader :mission

  def initialize
    puts "Welcome to Mission Control"
  end

  def set_mission_name
    puts "What is the name of this mission?"

    mission_name = gets.chomp
    @mission = Mission.new(name: mission_name)
  end
end