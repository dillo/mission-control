# frozen_string_literal: true

require_relative 'game'

game = Game.new
game.set_mission_name
puts "Mission name set to: #{game.mission.name}"