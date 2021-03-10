class ApplicationMailer < ActionMailer::Base
  default from: SiteConfig.mail_from
  layout "mailer"
end
