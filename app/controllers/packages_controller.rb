class PackagesController < ApplicationController
  include Pagy::Backend
  before_action -> { @package = current_user.packages.find(params[:id]) }, only: :destroy
  before_action -> { @all_packages = current_user.packages.includes(:package_items).order(updated_at: :desc) },
                   only: [:expected, :warehouse, :in_transit, :arrived]

  def index
    redirect_to action: "expected", status: :moved_permanently
  end

  def expected
    @pagy, @packages = pagy(@all_packages.expected)
    render :index
  end

  def warehouse
    @pagy, @packages = pagy(@all_packages.warehouse)
    render :index
  end

  def in_transit
    @pagy, @packages = pagy(@all_packages.in_transit)
    render :index
  end

  def arrived
    @pagy, @packages = pagy(@all_packages.arrived)
    render :index
  end

  def new
    @package = current_user.packages.build
    @package.package_items.build
  end

  def create
    @package = current_user.packages.build(package_params)
    if @package.save
      redirect_to packages_path, notice: t(".notice")
    else
      render :new
    end
  end

  def destroy
    return head(:bad_request) if @package.weight
    @package.destroy
    redirect_to packages_path, alert: t(".alert")
  end

  private
    def package_params
      params.require(:package).permit(
        :tracking,
        package_items_attributes: [:id, :_destroy, :description, :price, :qty]
      )
    end
end
