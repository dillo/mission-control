# frozen_string_literal: true

# spec/game_builder_spec.rb

require_relative '../game_builder'
require_relative '../mission_log'
require_relative '../game'

RSpec.describe GameBuilder do
  let(:default_log) { instance_double('MissionLog') }
  let(:custom_log) { instance_double('MissionLog') }
  let(:game) { instance_double('Game') }

  before do
    allow(MissionLog).to receive(:new).and_return(default_log)
    allow(Game).to receive(:new).and_return(game)
  end

  describe '#initialize' do
    it 'sets up a default MissionLog and an empty missions array' do
      builder = GameBuilder.new
      expect(builder.instance_variable_get(:@log)).to eq(default_log)
      expect(builder.instance_variable_get(:@missions)).to eq([])
    end
  end

  describe '#with_log' do
    it 'sets a custom log and returns the builder instance' do
      builder = GameBuilder.new
      result = builder.with_log(custom_log)
      expect(builder.instance_variable_get(:@log)).to eq(custom_log)
      expect(result).to be(builder)
    end
  end

  describe '#build' do
    it 'returns a new Game instance with the configured log' do
      builder = GameBuilder.new.with_log(custom_log)
      expect(Game).to receive(:new).with(log: custom_log).and_return(game)
      expect(builder.build).to eq(game)
    end
  end
end
