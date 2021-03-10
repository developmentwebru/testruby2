module Admin
  class PagesController < AdminController
    before_action -> { @page = Page.find(params[:id]) }, only: [:edit, :update, :destroy]

    def index
      @pages = Page.order(updated_at: :desc)
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        redirect_to admin_pages_path, notice: t(".notice")
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @page.update(page_params)
        redirect_to admin_pages_path, notice: t(".notice")
      else
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to admin_pages_path, alert: t(".alert")
    end

    private
      def page_params
        params.require(:page).permit(:slug, :title, :content)
      end
  end
end
