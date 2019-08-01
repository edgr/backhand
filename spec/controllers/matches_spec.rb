require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  describe "routes" do
    it { should route(:get, '/matches').to(action: :index) }
    it { should route(:post, '/matches').to(action: :create)}
  end

  describe "#index with user logged out" do
    before { get :index }
    it { expect(response).to have_http_status(302) }
    it { should redirect_to('/users/sign_in') }
  end

  describe "#new with user logged out" do
    before { get :new }
    it { expect(response).to have_http_status(302) }
    it { should redirect_to('/users/sign_in') }
  end

  describe "user logged in can access #index" do
    login_user
    it { expect(response).to have_http_status(:success) }
    before { get :index }
    it { should render_template("index") }
  end

  describe "user logged in can access #new" do
    login_user
    it { expect(response).to have_http_status(:success) }
    before { get :new }
    it { should render_template("new") }
  end

  describe "a logged in user can create a match" do
    login_user
    create_match
    it { should render_template("index") }
  end
end
