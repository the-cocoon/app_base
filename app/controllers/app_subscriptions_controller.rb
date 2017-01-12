class AppSubscriptionsController < ApplicationController
  layout false

  def app_sbuscribe
    if email = TheStringAddon.to_email(params[:email])
      AppSubscriptionsMailer.app_subscribe(email).deliver_now

      render json: {
        keep_alerts: true,
        flash: { notice: "`#{ email }` добавлен в списов подписчиков" },
        html_content: {
          set_value: {
            '.js--app-subscribe--form-input' => ''
          }
        }
      }
    else
      render json: {
        keep_alerts: true,
        flash: { warning: "Email не соответствует ожидаемому формату" }
      }
    end
  end
end