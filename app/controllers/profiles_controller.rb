class ProfilesController < ApplicationController
  skip_before_action :redirect_to_profile_setup?

  layout "devise"

  def new
    if current_user.profile
      redirect_to root_url
    else
      @profile = current_user.build_profile
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to root_url, notice: t("devise.registrations.signed_up")
    else
      render :new
    end
  end

  private
    def profile_params
      params.require(:profile).permit(
        :first_name,
        :last_name,
        :phone,
        :address,
        :city,
        passport_photos_attributes: [:id, :_destroy, :image]
      )
    end
end
