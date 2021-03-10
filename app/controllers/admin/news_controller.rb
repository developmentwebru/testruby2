module Admin
  class NewsController < AdminController
    before_action -> { @news = News.find(params[:id]) }, only: [:edit, :update, :destroy]

    def index
      @news = News.order(created_at: :desc)
    end

    def new
      @news = News.new
    end

    def create
      @news = News.new(news_params)
      if @news.save
        if params[:notify_users]
          User.find_each.with_index do |user, i|
            NewsMailer.with(user: user.email, news: @news).notify_user.deliver_later(wait: (i * 10).seconds)
          end
        end
        redirect_to admin_news_index_path, notice: t(".notice")
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @news.update(news_params)
        redirect_to admin_news_index_path, notice: t(".notice")
      else
        render :edit
      end
    end

    def destroy
      @news.destroy
      redirect_to admin_news_index_path, alert: t(".alert")
    end

    private
      def news_params
        params.require(:news).permit(:title, :content)
      end
  end
end
