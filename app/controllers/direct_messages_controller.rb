class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @receiver = User.find(params[:receiver_id])
    @direct_message = DirectMessage.new
  end

  def index
    # 受信したメッセージと送信したメッセージを取得
    @received_messages = current_user.received_direct_messages
    @sent_messages = current_user.sent_direct_messages
  end


  def create
    # logger.debug "params: #{params.inspect}"  # パラメータをログに出力
    @receiver = User.find(params[:direct_message][:receiver_id])  # 受信者を取得

    # 相互フォローしているか確認
    if current_user.following?(@receiver) && @receiver.following?(current_user)
      @direct_message = DirectMessage.new(direct_message_params)  # フォームからのデータを元に新しいメッセージを作成
      @direct_message.sender = current_user  # 現在のユーザーを送信者として設定
      @direct_message.receiver = @receiver

      if @direct_message.save  # データベースに保存
        redirect_to direct_messages_path, notice: 'メッセージを送信しました。'
      else
        render :new # 保存に失敗した場合は再度フォームを表示
      end
    else
      redirect_to direct_messages_path, alert: '相互フォローしているユーザーのみメッセージを送信できます。'
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:content)
  end
end
