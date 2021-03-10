class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  layout "marketing"

  def index
  end

  def show
    @page = Page.find_by(slug: params[:slug])
  end

  def contacts
  end

  def stores
  end

  def find_tracking
    if params[:q] && params[:q].size == 6
      @package = Package.find_by("tracking LIKE ?", "%#{params[:q]}")
    elsif params[:q] && params[:q].size > 6
      @package = Package.find_by("tracking LIKE ?", "%#{params[:q]}")
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def us_address
  end

  def turkey
  end
end
