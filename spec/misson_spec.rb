require_relative "spec_helper"
require_relative "../mission"

RSpec.describe Mission do
  let(:mission) { described_class.new(name: "First Mission") }

  it "initializes with a name attribute" do
    expect(mission.name).to eq("First Mission")
  end
end