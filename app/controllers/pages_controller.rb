class PagesController < ApplicationController
  def dashboard
    @searches = current_user.searches
  end
end
