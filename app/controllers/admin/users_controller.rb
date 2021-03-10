module Admin
  class UsersController < AdminController
    include Pagy::Backend

    def index
      @last_week = 7.days.ago.beginning_of_day..Time.current
      @last_month = 1.month.ago.beginning_of_day..Time.current
      @last_three_months = 3.months.ago.beginning_of_day..Time.current

      @signedup_last_week = User.where(created_at: @last_week).count
      @signedup_last_week_profile = User.includes(:profile)
                                         .where(created_at: @last_week)
                                         .where.not(profiles: {id: nil}).count

      @signedup_last_month = User.where(created_at: @last_month).count
      @signedup_last_month_profile = User.includes(:profile)
                                          .where(created_at: @last_month)
                                          .where.not(profiles: {id: nil}).count

      @signedup_last_three_months = User.where(created_at: @last_three_months).count
      @signedup_last_three_months_profile = User.includes(:profile)
                                                 .where(created_at: @last_three_months)
                                                 .where.not(profiles: {id: nil}).count


      if params[:search] && !params[:search].blank?
        @users_total = User.includes(:profile).search_by_name_and_email(params[:search])
        @pagy, @users = pagy(@users_total)
      elsif params[:show_admins]
        @users_total = User.includes(:profile).where("admin = true OR super_admin = true")
        @pagy, @users = pagy(@users_total)
      else
        @users_total = User.includes(:profile).where.not(profiles: {id: nil}).order("profiles.created_at desc")
        @pagy, @users = pagy(@users_total)
      end
    end

    def become
      return unless current_user.super_admin?
      sign_in(:user, User.find(params[:id]))
      redirect_to root_url
    end

    def edit
      user = User.find(params[:id])
      @profile = user.profile
    end

    def update
      user = User.find(params[:id])
      @profile = user.profile
      if @profile.update(profile_params)
        redirect_to edit_admin_user_path, notice: "Профиль ##{user.id} обновлен"
      else
        render :edit
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
end
