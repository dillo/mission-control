# frozen_string_literal: true

# spec/rocket_spec.rb

require_relative '../rocket'

RSpec.describe Rocket do
  let(:rocket) do
    Rocket.new(
      destination_distance: 500,
      fuel_capacity: 1000,
      burn_rate: 10,
      payload_capacity: 5000,
      average_speed: 100
    )
  end

  describe '#initialize' do
    it 'initializes with the correct attributes' do
      expect(rocket.destination_distance).to eq(500)
      expect(rocket.fuel_capacity).to eq(1000)
      expect(rocket.burn_rate).to eq(10)
      expect(rocket.payload_capacity).to eq(5000)
      expect(rocket.average_speed).to eq(100)
      expect(rocket.distance_traveled).to eq(0)
      expect(rocket.fuel_remaining).to eq(1000)
      expect(rocket.total_fuel_burned).to eq(0)
    end
  end

  describe '#reset_distance_traveled' do
    it 'resets the distance traveled to zero' do
      rocket.distance_traveled = 200
      rocket.reset_distance_traveled
      expect(rocket.distance_traveled).to eq(0)
    end
  end

  describe '#burn_fuel' do
    it 'reduces fuel remaining and increases total fuel burned' do
      rocket.burn_fuel(10)
      expect(rocket.fuel_remaining).to eq(900)
      expect(rocket.total_fuel_burned).to eq(100)
    end

    it 'does not allow fuel remaining to go below zero' do
      rocket.burn_fuel(150)
      expect(rocket.fuel_remaining).to eq(0)
      expect(rocket.total_fuel_burned).to eq(1000)
    end
  end

  describe '#update_distance' do
    it 'increases distance traveled based on time elapsed' do
      rocket.update_distance(60)
      expect(rocket.distance_traveled).to eq(100)
    end

    it 'does not allow distance traveled to exceed destination distance' do
      rocket.update_distance(600)
      expect(rocket.distance_traveled).to eq(500)
    end
  end

  describe '#launch' do
    it 'simulates the rocket launch until fuel runs out or destination is reached' do
      rocket_with_enough_fuel = Rocket.new(
        destination_distance: 500,
        fuel_capacity: 3000, # Adjust the fuel capacity so the rocket can reach the destination
        burn_rate: 10,
        payload_capacity: 5000,
        average_speed: 100
      )

      expect { rocket_with_enough_fuel.launch }.to change { rocket_with_enough_fuel.distance_traveled }.from(0).to(500)
    end
  end

  describe '#current_status' do
    it 'returns the current status of the rocket as a hash' do
      rocket.burn_fuel(10)
      rocket.update_distance(60)
      status = rocket.current_status

      expect(status[:fuel_burn_rate]).to eq(10)
      expect(status[:speed]).to eq(100)
      expect(status[:distance_traveled]).to eq(100.0)
      expect(status[:fuel_remaining]).to eq(900)
    end
  end
end
