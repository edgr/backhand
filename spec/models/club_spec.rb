require 'rails_helper'

RSpec.describe Club, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:courts) }
    it { is_expected.to have_many(:matches) }
    it { is_expected.to have_many(:users) }
  end

  describe "callbacks" do
    describe ".set_slug" do
      subject { club.save }

      let(:club) { build :club, name: "foo bar" }

      it "sets the slug correctly" do
        expect { subject }.to change(club, :slug).from(nil).to("foo-bar")
      end
    end
  end

  describe "instance methods" do
    let(:club) { create :club }
    let!(:court1) { create :court, club: club, surface: "Grass", indoor: true, lights: false, single: true }
    let!(:court2) { create :court, club: club, surface: "Clay", indoor: true, lights: false, single: true }
    let!(:court3) { create :court, club: club, surface: "Carpet", indoor: true, lights: false, single: false }
    let!(:court4) { create :court, club: club, surface: "Grass", indoor: false, lights: false, single: false }
    let!(:court5) { create :court, club: club, surface: "Grass", indoor: false, lights: true, single: true }
    let!(:court6) { create :court, club: club, surface: "Hard", indoor: true, lights: true, single: false }

    describe "#clay_courts" do
      subject { club.clay_courts }

      it { is_expected.to match_array [court2] }
    end

    describe "#hard_courts" do
      subject { club.hard_courts }

      it { is_expected.to match_array [court6] }
    end

    describe "#grass_courts" do
      subject { club.grass_courts }

      it { is_expected.to match_array [court1, court4, court5] }
    end

    describe "#carpet_courts" do
      subject { club.carpet_courts }

      it { is_expected.to match_array [court3] }
    end

    describe "#courts_indoors" do
      subject { club.courts_indoors }

      it { is_expected.to match_array [court1, court2, court3, court6] }
    end

    describe "#courts_with_lights" do
      subject { club.courts_with_lights }

      it { is_expected.to match_array [court5, court6] }
    end

    describe "#singles_courts" do
      subject { club.singles_courts }

      it { is_expected.to match_array [court1, court2, court5] }
    end
  end
end
