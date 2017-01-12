class DeviseMailer < Devise::Mailer
  include ::UserRoom::MailerSettingsConcern
  include ::UserRoom::DeviseMailerExtention

  # Add View Helper for Mailer Preview Fix
  add_template_helper(MailerImageTagHelper)

  prepend_view_path "#{ ::UserRoom::Engine.root }/app/views/user_room"
  layout 'mailers/app_layout'

  # For MAILER TEMPLATE
  # view_path + template_path + template_name
  default template_path: [ 'user_room/devise/mailer' ]

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # INJECT FROM APP VIEW ENGINE
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  voiceless do
    prepend_view_path "#{ ::AppViewEngine::Engine.root }/app/views"
    include ::AppViewEngine::MailerAttachments
  end

  # def set_attachments!
  #   @images = {
  #     'ok_logo.png'      => '/logos/ok_w350_h100.png',
  #     'ok_shop_logo.png' => '/logos/ok_shop_w350_h100.png'
  #   }
  #   @images.each_pair do |name, path|
  #     attachments.inline[name] = File.read("#{ Rails.root }/public/#{ path }")
  #   end
  # end
end