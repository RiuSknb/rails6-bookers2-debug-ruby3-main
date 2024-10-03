class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy



  # フォローする側としての関係
  has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
      # has_many :relationships: このユーザーがフォロワーとして持つリレーションシップを定義します。
      # foreign_key: :follower_id　：フォロワーIDを指定しています。

  has_many :followings, through: :relationships, source: :followed
      # has_many :followed_users: このユーザーがフォローしているユーザーのリストを取得します。
      # through オプションを使って、relationships を介して followed に関連するユーザーを指定しています。


  # フォローされる側の関係
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
      # has_many :inverse_relationships: このユーザーがフォローされる側のリレーションシップを定義します。
      # ここでは、クラス名を明示的に指定することで、逆の関係を作成しています。
  has_many :followers, through: :inverse_relationships, source: :follower
      # has_many :followers: このユーザーをフォローしているユーザーのリストを取得します。


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # フォローする
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  # フォロー解除する
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  # すでにフォローしているか確認する
  def following?(user)
    followings.include?(user)
  end
end
