# frozen_string_literal: true

# spec/game_spec.rb
require 'rspec'
require_relative '../game'
require_relative '../mission'
require_relative '../mission_log'

RSpec.describe Game do
  let(:log) { instance_double(MissionLog) }
  let(:game) { Game.new(log:) }
  let(:mission) { instance_double(Mission, name: 'Test Mission') }

  describe '#initialize' do
    it 'initializes with a log and an empty missions array' do
      expect(game.log).to eq(log)
      expect(game.missions).to eq([])
    end
  end

  describe '#run' do
    before do
      allow(game).to receive(:create_and_execute_mission).and_return(mission, nil)
      allow(game).to receive(:play_again?).and_return(false)
      allow(log).to receive(:print_all_missions_status)
    end

    it 'creates and executes missions, and logs them' do
      game.run
      expect(game.missions).to include(mission)
      expect(log).to have_received(:print_all_missions_status).with([mission])
    end
  end

  describe '#create_and_execute_mission' do
    before do
      allow(Mission).to receive(:new).and_return(mission)
      allow(mission).to receive(:run)
    end

    it 'creates and executes a new mission' do
      result = game.send(:create_and_execute_mission)
      expect(result).to eq(mission)
    end

    it 'returns nil if the mission has no name' do
      allow(mission).to receive(:name).and_return(nil)
      result = game.send(:create_and_execute_mission)
      expect(result).to be_nil
    end
  end

  describe '#play_again?' do
    before do
      allow(game).to receive(:gets).and_return(double(chomp: 'y'))
    end

    it 'asks the user if they want to run another mission' do
      result = game.send(:play_again?)
      expect(result).to be true
    end

    it 'returns false if the user does not want to play again' do
      allow(game).to receive(:gets).and_return(double(chomp: 'n'))
      result = game.send(:play_again?)
      expect(result).to be false
    end
  end
end
