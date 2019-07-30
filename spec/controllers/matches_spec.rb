require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  it { should route(:get, '/matches').to(action: :index) }
  describe "#index" do
    it "should return all matches" do

    end
  end
end
