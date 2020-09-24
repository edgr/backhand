require 'rails_helper'

RSpec.describe Court, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:club).optional }
  end

  describe "scopes" do
    describe ".those_indoor" do
      subject { described_class.those_indoor }
      let!(:court1) { create :court, indoor: true }
      let!(:court2) { create :court, indoor: false }
      let!(:court3) { create :court, indoor: true }
      let!(:expected_result) { [court1, court3] }

      it { is_expected.to match_array expected_result }
    end

    describe ".those_single" do
      subject { described_class.those_single }
      let!(:court1) { create :court, single: false }
      let!(:court2) { create :court, single: true }
      let!(:court3) { create :court, single: true }
      let!(:expected_result) { [court2, court3] }

      it { is_expected.to match_array expected_result }
    end

    describe ".with_lights" do
      subject { described_class.with_lights }
      let!(:court1) { create :court, lights: false }
      let!(:court2) { create :court, lights: true }
      let!(:court3) { create :court, lights: false }
      let!(:expected_result) { [court2] }

      it { is_expected.to match_array expected_result }
    end

    describe ".with_surface" do
      subject { described_class.with_surface(surface_type) }
      let(:surface_type) { "Grass" }
      let!(:court1) { create :court, surface: "Grass" }
      let!(:court2) { create :court, surface: "Carpet" }
      let!(:court3) { create :court, surface: "Hard" }
      let!(:expected_result) { [court1] }

      it { is_expected.to match_array expected_result }
    end
  end
end
