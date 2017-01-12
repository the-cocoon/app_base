module ControllerRestrictions
  extend ActiveSupport::Concern

  included do; end

  private

  def user_require
    not_authenticated unless authenticate_user!
  end

  def owner_required
    not_authenticated unless current_user.owner?(@owner_check_object)
  end

  def admin_require
    return not_authenticated unless current_user
    not_authenticated unless current_user.admin?
  end

  def not_authenticated
    return redirect_to root_path, flash: { error: "Недостаточно прав" } if current_user
    redirect_to new_user_session_path, notice: 'Необходимо войти в систему'
  end

  def page_404
    raise ::AppError::Error404
  end
end