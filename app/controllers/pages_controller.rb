class PagesController < ApplicationController
  def dashboard
    @searches = current_user.searches.limit(5)
  end
end
