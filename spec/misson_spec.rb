require_relative "spec_helper"
require_relative "../mission"
require_relative "../rocket"

RSpec.describe Mission do
  let(:rocket) { Rocket.new }
  let(:mission) { described_class.new(name: "First Mission", rocket: rocket) }

  it "initializes with a name attribute" do
    expect(mission.name).to eq("First Mission")
  end

  it "initializes with a rocket" do
    expect(mission.rocket).to be_a(Rocket)
  end
end