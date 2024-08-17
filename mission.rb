# frozen_string_literal: true

class Mission
  attr_reader :name, :rocket

  def initialize(name:, rocket:)
    @name = name
    @rocket = rocket
  end
end