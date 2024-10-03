class SearchesController < ApplicationController

  def search
    @model = params[:model]  # ユーザーか投稿かを選択
    @keyword = params[:keyword]  # 検索キーワード
    @method = params[:search_method] # 検索手法

    if @model == "user"
      @results = User.where("name LIKE ?", "%#{@keyword}%")
    elsif @model == "book"
      @results = Book.where("title LIKE ?", "%#{@keyword}%")
    end
  end


  private


    # 検索メソッドのロジック
  def search_for(model, attribute)
    case @method
    when 'match'
      model.where("#{attribute} LIKE ?", "#{@keyword}")
    when 'forward'
      model.where("#{attribute} LIKE ?", "#{@keyword}%")
    when 'backward'
      model.where("#{attribute} LIKE ?", "%#{@keyword}")
    when 'partial'
      model.where("#{attribute} LIKE ?", "%#{@keyword}%")
    else
      model.none  # 手法が選択されていない場合は空の結果
    end
  end
end
