# frozen_string_literal: true

require_relative "mission"

class Game
  attr_reader :mission

  def initialize
    puts "Welcome to Mission Control"
  end
end