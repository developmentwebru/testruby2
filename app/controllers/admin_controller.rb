class AdminController < ApplicationController
  before_action :authenticate_admin!

  layout "admin"

  private
    def authenticate_admin!
      unless current_user.try(:admin?) || current_user.try(:super_admin?)
        redirect_to root_path
      end
    end
end
