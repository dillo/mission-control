# frozen_string_literal: true

class Mission
  attr_reader :name

  def initialize(name:)
    @name = name
  end
end