class NewsController < ApplicationController
  skip_before_action :authenticate_user!

  layout "marketing"
  
  def index
    @news = News.order(created_at: :desc)
  end

  def show
    @news = News.find(params[:id])
  end
end
