module MailerImageTagHelper
  def mailer_image_tag path, opts = {}
    path = Rails.env.development? ? @images[path] : attachments[path].url
    image_tag path, opts
  end
end
