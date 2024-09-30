class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :user_id, uniqueness: {scope: :book_id}
  
  
  # バリデーションにおいてuniquenessを指定することで、
  # validatesメソッドの引数であるuser_idカラムの値がすでにテーブルに
  # 保存されている値と重複していないかをチェックしてくれるようになります。
end
