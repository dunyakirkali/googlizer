class HomeController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def index
  end

  def dashboard
    @searches = current_user.searches.order(created_at: :desc).limit(5)
  end
end
