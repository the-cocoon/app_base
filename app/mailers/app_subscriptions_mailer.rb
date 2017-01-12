class AppSubscriptionsMailer < ActionMailer::Base
  layout 'mailers/app_inform_layout'
  default template_path: [ 'app_subscriptions_mailer' ]

  voiceless { prepend_view_path "#{ ::AppViewEngine::Engine.root }/app/views" }

  # AppSubscriptionsMailer.app_subscribe('test@test.com')
  def app_subscribe email
    @email = email
    mail(subject: "#{ env_prefix }Запрос на получение информационной рассылки")
  end

  # HELPERS

  def self.smtp?
    ['smtp', 'letter_opener'].include?(::Settings.app.mailer.service)
  end

  if smtp?
    _mailer = ::Settings.app.mailer

    default from: _mailer.smtp.default.user_name
    default to:   _mailer.admin_email
    default bcc:  _mailer.admin_email

    default template_path: [ 'app_subscriptions_mailer' ]

    def self.smtp_settings
      ::Settings.app.mailer.smtp.default.to_h
    end
  end

  private

  def env_prefix
    'DEV => ' if Rails.env.development?
  end
end