class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id]) # 該当する本のIDを抜き出す
    favorite = current_user.favorites.new(book_id: book.id)
    # ログインしているユーザーの"has_many: favorites"コレクション（概念：表）の
    # book_id列に、今の本のIDを記入する

    favorite.save   # データをアップする
    redirect_to request.referer   # 直前のページに戻る
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end
end
