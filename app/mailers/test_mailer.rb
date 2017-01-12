class TestMailer < ApplicationMailer
  layout false

  # TestMailer.test.deliver_now

  def test
    mail(
      to:   ::Settings.app.mailer.admin_email,
      from: ::Settings.app.mailer.admin_email,
      subject: "Test Letter"
    )
  end
end
