class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, except: [:top, :about] # top, about の2つのアクションのみ、ログイン無しでもアクセス可能にする
  before_action :configure_permitted_parameters, if: :devise_controller?
#   before_action :authenticate_user!は、deviseを入れると使えるようになるヘルパーメソッドであり、
# コントローラーに設定することで、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
# controller/application_controller.rbに書いてしまうと、
# 全コントローラに適用されてしまい、ログインが関係ないところにも実行されてしまうため、
# 制限が必要ない、トップページ・アバウトページにもかかってしまいます。
# bookとuserのcontrollerだけに、before_action :authenticate_user!を追記してあげましょう。



  private

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
