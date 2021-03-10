class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_to_profile_setup?, unless: :devise_controller?

  private
    def redirect_to_profile_setup?
      if user_signed_in?
        unless current_user.profile || current_user.admin? || current_user.super_admin?
          redirect_to new_profile_url
        end
      end
    end
end
