class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @receiver = User.find(params[:receiver_id])

    # 相互フォローしているか確認
    if current_user.following?(@receiver) && @receiver.following?(current_user)
      @direct_message = DirectMessage.new(direct_message_params)
      @direct_message.sender = current_user
      @direct_message.receiver = @receiver

      if @direct_message.save
        redirect_to direct_messages_path, notice: 'メッセージを送信しました。'
      else
        render :new
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
