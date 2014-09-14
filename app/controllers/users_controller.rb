class UsersController < ApplicationController
  before_action :authenticate_user!

  def activate
    current_user.activate
    redirect_to root_path, flash: { success: 'Googlizer active!' }
  end

  def deactivate
    current_user.deactivate
    redirect_to root_path, flash: { alert: 'Googlizer inactive!' }
  end
end
