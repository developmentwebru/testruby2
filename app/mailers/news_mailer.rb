class NewsMailer < ApplicationMailer
  def notify_user
    @user = params[:user]
    @news = params[:news]
    mail(to: @user, subject: @news.title)
  end
end
