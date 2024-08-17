# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../game'

RSpec.describe Game do
  subject { described_class.new }

  describe "#initialize" do
    it "displays a welcome message" do
      expect { subject }.to output("Welcome to Mission Control\n").to_stdout
    end
  end
end