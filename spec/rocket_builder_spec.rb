# frozen_string_literal: true

# spec/rocket_builder_spec.rb

require_relative '../rocket_builder'

RSpec.describe RocketBuilder do
  let(:builder) { RocketBuilder.new }

  describe '#initialize' do
    it 'initializes with default values' do
      expect(builder.instance_variable_get(:@destination_distance)).to eq(160)
      expect(builder.instance_variable_get(:@fuel_capacity)).to eq(1_514_100)
      expect(builder.instance_variable_get(:@burn_rate)).to eq(168_233)
      expect(builder.instance_variable_get(:@payload_capacity)).to eq(50_000)
      expect(builder.instance_variable_get(:@average_speed)).to eq(1500)
    end
  end

  describe '#with_destination_distance' do
    it 'sets the destination distance and returns the builder' do
      result = builder.with_destination_distance(300)
      expect(builder.instance_variable_get(:@destination_distance)).to eq(300)
      expect(result).to be_a(RocketBuilder)
    end
  end

  describe '#with_fuel_capacity' do
    it 'sets the fuel capacity and returns the builder' do
      result = builder.with_fuel_capacity(2_000_000)
      expect(builder.instance_variable_get(:@fuel_capacity)).to eq(2_000_000)
      expect(result).to be_a(RocketBuilder)
    end
  end

  describe '#with_burn_rate' do
    it 'sets the burn rate and returns the builder' do
      result = builder.with_burn_rate(200_000)
      expect(builder.instance_variable_get(:@burn_rate)).to eq(200_000)
      expect(result).to be_a(RocketBuilder)
    end
  end

  describe '#with_payload_capacity' do
    it 'sets the payload capacity and returns the builder' do
      result = builder.with_payload_capacity(60_000)
      expect(builder.instance_variable_get(:@payload_capacity)).to eq(60_000)
      expect(result).to be_a(RocketBuilder)
    end
  end
end
