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

  describe "#set_mission_name" do
    it "prompts the user to set the mission name" do
      allow(subject).to receive(:gets).and_return("Apollo")
      subject.set_mission_name
      expect(subject.mission.name).to eq("Apollo")
    end
  end
end