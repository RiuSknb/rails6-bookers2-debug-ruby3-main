class SearchesController < ApplicationController
  
  def search
    @model = params[:model]  # ユーザーか投稿かを選択
    @keyword = params[:keyword]  # 検索キーワード
    
    if @model == "user"
      @results = User.where("name LIKE ?", "%#{@keyword}%")
    elsif @model == "book"
      @results = Book.where("title LIKE ?", "%#{@keyword}%")
    end
  end
end
