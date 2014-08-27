class UsersController < ApplicationController
  def activate
    current_user.activate
    redirect_to root_path
  end

  def deactivate
    current_user.deactivate
    redirect_to root_path
  end
end
