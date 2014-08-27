require 'rails_helper'

RSpec.describe UserController, :type => :controller do

  describe "GET activate" do
    it "returns http success" do
      get :activate
      expect(response).to be_success
    end
  end

  describe "GET deactivate" do
    it "returns http success" do
      get :deactivate
      expect(response).to be_success
    end
  end

end
