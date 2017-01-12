class ApplicationController < ActionController::Base
  before_action :redirect_router

  include ::ControllerRestrictions
  include ::UserRoom::ApplicationController

  include ::TheCommentsBase::ViewToken
  def comments_cookies_token; 'TheComments3Cookies'; end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def render_json template_name
    respond_to do |format|
      format.json { render layout: false, template: template_name }
    end
  end

  def render_json_template tmpl_path
    render layout: false, template: tmpl_path, formats: [:json]
  end

  def redirect_router
    if redirect_router = RedirectRouter.where(from_url: [request.fullpath, request.path]).first
      redirect_router.increment!(:redirect_count)
      return redirect_to redirect_router.to_url, status: redirect_router.status_code
    end
  end
end
