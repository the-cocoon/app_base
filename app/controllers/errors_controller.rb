class ErrorsController < ActionController::Base
  layout false

  def show
    respond_to do |format|
      format.html { render page_for_status_code, locals: { status_code: status_code }, status: render_status_code }
      format.json { render json: error_json_data, status: render_status_code }
      format.js   { render json: error_json_data, status: render_status_code }
      format.any  { render nothing: true, status: render_status_code }
    end
  end

  private

  def error_json_data
    data = {
      flash: {
        notice: t("http_errors.#{status_code}", default: :'http_errors.other')
      }
    }
  end

  def exception
    env['action_dispatch.exception']
  end

  # class PageNotFound < StandartError
  #   def message
  #     'Page not found'
  #   end
  #
  #   def status_code
  #     404
  #   end
  # end
  #
  # raise PageNotFound
  #
  def exception_status_code
    exception.try(:status_code)
  end

  # def show
  #   params[:error_status_code] = 500
  #   raise PageNotFound
  # end
  #
  def params_status_code
    params[:error_status_code]
  end

  # Rack::Util/HTTP_STATUS_CODES
  def dispatch_status_code
    ActionDispatch::ExceptionWrapper.new(env, exception).status_code
  end

  def status_code
    @_status_code ||= (params_status_code || exception_status_code || dispatch_status_code).to_s
  end

  def page_for_status_code
    %w[404 422].include?(status_code) ? status_code : '500'
  end

  # We can't return status codes `5xx`
  # Because in this case Nginx will catch response and render his own error page
  # That is why we should return any `client side errror status`. For instance, `400` (Bad request)
  # Also we shouldn't return `200`, because in this case Search Engine may add this page to Index
  #
  def render_status_code
    status_code.to_i >= 500 ? 400 : status_code.to_i
  end

  # We did it with this way, because it looks impossible to pass flash messages on redirect from `exceptions_app`
  # That is why some specific cases we will catch directly in Controllers
  # Add `include ::ErrorsController::CustomHandlers` to required controllers
  #
  module CustomHandlers
    extend ActiveSupport::Concern

    included do
      rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_authenticity_token_handler

      private

      def invalid_authenticity_token_handler(exception)
        # Because of flash messages on redirect we have to use `rescue_from`
        # Because of `rescue_from` Rollbar can't process exceptions automatically
        # There is a way how to build warning message in Rollbar properly
        #
        Rollbar.warning(exception, 'Invalid Authenticity Token')

        json_respond = {
          flash: {
            notice: t('authenticity_token.invalid.xhr_request')
          }
        }

        respond_to do |format|
          format.html do
            back_url = request.referer || root_path
            redirect_to back_url, alert: t('authenticity_token.invalid.html_request')
          end

          format.json { render json: json_respond, status: :unauthorized }
          format.js   { render json: json_respond, status: :unauthorized }
          format.any  { render nothing: true, status: :unauthorized }
        end
      end # invalid_authenticity_token_handler
    end # included
  end # CustomHandlers

end
