# frozen_string_literal: true

# spec/rocket_factory_spec.rb

require_relative '../rocket_factory'
require_relative '../rocket_builder'

RSpec.describe RocketFactory do
  describe '.build_rocket' do
    let(:rocket_builder) { instance_double('RocketBuilder') }
    let(:rocket) { instance_double('Rocket') }

    before do
      allow(RocketBuilder).to receive(:new).and_return(rocket_builder)
      allow(rocket_builder).to receive(:with_destination_distance).and_return(rocket_builder)
      allow(rocket_builder).to receive(:with_fuel_capacity).and_return(rocket_builder)
      allow(rocket_builder).to receive(:with_burn_rate).and_return(rocket_builder)
      allow(rocket_builder).to receive(:with_payload_capacity).and_return(rocket_builder)
      allow(rocket_builder).to receive(:with_average_speed).and_return(rocket_builder)
      allow(rocket_builder).to receive(:build).and_return(rocket)
    end

    it 'builds a rocket with the correct attributes' do
      result = RocketFactory.build_rocket

      expect(RocketBuilder).to have_received(:new)
      expect(rocket_builder).to have_received(:with_destination_distance).with(160)
      expect(rocket_builder).to have_received(:with_fuel_capacity).with(1_514_100)
      expect(rocket_builder).to have_received(:with_burn_rate).with(168_233)
      expect(rocket_builder).to have_received(:with_payload_capacity).with(50_000)
      expect(rocket_builder).to have_received(:with_average_speed).with(1500)
      expect(rocket_builder).to have_received(:build)
      expect(result).to eq(rocket)
    end
  end
end
