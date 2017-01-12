# http://localhost:3000/rails/mailers

class MailerPreview < ActionMailer::Preview
  def APP_subscribe
    AppSubscriptionsMailer.app_subscribe(email = 'test@test.com')
  end

  def DEVISE_reset_password_instructions
    DeviseMailer.reset_password_instructions(User.last, {})
  end

  def DEVISE_confirmation_instructions
    DeviseMailer.confirmation_instructions(User.last, {})
  end

  def DEVISE_Mail_Registration_Request
    reg_req = EmailRegistrationRequest.last
    EmailRegistrationRequest.create!(email: "x@x.ru") unless reg_req
    DeviseMailer.mail_registration_request(reg_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_Onetime_Login_Request
    log_req = OnetimeLoginLink.last
    OnetimeLoginLink.create!(email: "x@x.ru") unless log_req
    DeviseMailer.onetime_login_request(log_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_New_User_Created
    user_id = User.first.id
    DeviseMailer.new_user_created(user_id)
  end

  def RAILS_SHOP_one_click_order
    OrderMailer.one_click('+791000011122', 'Product', '12')
  end

  def RAILS_SHOP_order_created
    order = Order.last
    OrderMailer.created(order.id)
  end

  def RAILS_SHOP_order_moderation
    order = Order.last
    OrderMailer.moderation(order.id)
  end

  def RAILS_SHOP_order_ready_to_payment
    order = Order.last
    OrderMailer.ready_to_payment(order.id)
  end

  def RAILS_SHOP_order_paid
    order = Order.last
    OrderMailer.paid(order.id)
  end

  def RAILS_SHOP_unexpected_transition
    order = Order.last
    OrderMailer.unexpected_transition(order.id, [:draft, :published])
  end

  def RAILS_SHOP_logger_product_added_to_cart
    cart    = Cart.last
    product = Product.last
    RailsShopLoggerMailer.product_added_to_cart(cart.id, product.id)
  end

  def RAILS_SHOP_logger_product_removed_from_cart
    cart    = Cart.last
    product = Product.last

    RailsShopLoggerMailer.product_removed_from_cart(cart.id, product.id)
  end

  def RAILS_SHOP_logger_payment_system
    order = Order.last

    RailsShopLoggerMailer.selected_payment_system(order.id, "CARD")
  end

  def THE_COMMENTS_new_comment
    TheCommentsSubscriptionsMailer.notificate("x@x", Comment.last)
  end
end
