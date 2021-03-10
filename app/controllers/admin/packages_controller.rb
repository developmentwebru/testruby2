module Admin
  class PackagesController < AdminController
    include Pagy::Backend
    before_action -> { @package = Package.find(params[:id]) }, only: [:edit, :update, :destroy, :cn23]
    before_action -> { @qr = RQRCode::QRCode.new(request.original_url) }, only: [:edit, :update]

    def index
      packages = Package.includes(:guest, :user, :profile, :package_items).order(updated_at: :desc)
      @pagy, @packages = 
        if params[:search]
          tracking = params[:search].upcase
          pagy(packages.where("tracking LIKE ?", "%#{tracking}"))
        elsif params[:search_by_name] && !params[:search_by_name].blank?
          pagy(packages.search_by_name(params[:search_by_name]))
        else
          pagy(packages)
        end
    end

    def new_or_edit
      tracking_query = params[:q].upcase
      tracking_sanitized = Tracking.sanitize(tracking_query)
      tracking = tracking_sanitized[:tracking]
      fedex_smart_post_without_prefix = tracking_sanitized[:fedex_smart_post_without_prefix]

      # Temporary search to avoid USPS 42019701 prefix, change to (tracking: tracking) after 10 days
      @package = Package.find_by("tracking LIKE ?", "%#{tracking}")
      if !@package && fedex_smart_post_without_prefix
        @package = Package.find_by(tracking: tracking[2..-1])
      end

      if @package
        redirect_to edit_admin_package_path(@package.id)
      else
        redirect_to new_admin_package_path(tracking: tracking)
      end
    end

    def set_as_received
      tracking_query = params[:q].upcase
      tracking_sanitized = Tracking.sanitize(tracking_query)
      tracking = tracking_sanitized[:tracking]
      fedex_smart_post_without_prefix = tracking_sanitized[:fedex_smart_post_without_prefix]

      @package = Package.find_by("tracking LIKE ?", "%#{tracking}")
      if !@package && fedex_smart_post_without_prefix
        @package = Package.find_by(tracking: tracking[2..-1])
      end

      if @package && !@package.received_at # Not received yet
        @package.update(received_at: Time.current)
        redirect_to admin_packages_path, notice: t(".notice", tracking_number: @package.tracking)
      elsif @package # Already received package
        redirect_to admin_packages_path, alert: t(".alert", tracking_number: @package.tracking)
      else # Package not found in system, ignore
        redirect_to admin_packages_path
      end
    end

    def new
      @package = Package.new(tracking: params[:tracking])
      @package.build_guest
      @package.package_items.build
    end

    def create
      @package = Package.new(package_params)
      if @package.save(context: :admin)
        redirect_to admin_packages_path, notice: t(".notice")
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @package.update(package_params) && @package.valid?(:admin)
        redirect_to admin_packages_path, notice: t(".notice")
      else
        render :edit
      end
    end

    def destroy
      @package.destroy
      redirect_to admin_packages_path, alert: t(".alert")
    end

    def cn23
      render layout: "print"
    end

    private
      def package_params
        params.require(:package).permit(
          :tracking,
          :weight,
          guest_attributes: [:first_name, :last_name],
          package_items_attributes: [:id, :_destroy, :description, :price, :qty],
          package_photos_attributes: [:id, :_destroy, :image]
        )
      end
  end
end
