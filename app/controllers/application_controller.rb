class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #サインアップ、サインイン時にemailとパスワード以外も保存できるようにする
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_deleted, :name])
  end

  private
  #adminでサインインしたときはadminのホームに遷移するように設定
  def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(Admin)
          admin_homes_top_path
      else
          posts_path
      end
  end

  # adminでサインアウトしたときはadminのログイン画面に遷移するように設定
  def
   after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :customer
          root_path
      elsif resource_or_scope == :admin
          new_admin_session_path
      else
          root_path
      end
  end

end