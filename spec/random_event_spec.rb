# frozen_string_literal: true

# spec/random_event_spec.rb

require_relative '../random_event'

RSpec.describe RandomEvent do
  let(:random_event) { RandomEvent.new(1234) }
  let(:rocket) { double('Rocket', destination_distance: 1000.0, average_speed: 500.0) }

  describe '#should_abort?' do
    it 'returns true approximately 1/3 of the time' do
      results = Array.new(3000) { random_event.should_abort? }
      true_count = results.count(true)
      expect(true_count).to be_within(100).of(1000) # 1/3 of 3000 is 1000
    end
  end

  describe '#should_explode?' do
    it 'returns true approximately 1/5 of the time' do
      results = Array.new(5000) { random_event.should_explode? }
      true_count = results.count(true)
      expect(true_count).to be_within(100).of(1000) # 1/5 of 5000 is 1000
    end
  end

  describe '#random_distance_and_time' do
    it 'returns an array with the correct distance and time based on the rocket attributes' do
      allow(random_event.random).to receive(:rand).with(2).and_return(0.5)
      distance, time = random_event.random_distance_and_time(rocket)
      expect(distance).to eq(500.0) # 1000.0 * 0.5
      expect(time).to eq(250.0) # 500.0 * 0.5
    end
  end
end
