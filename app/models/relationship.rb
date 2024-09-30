class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"    # フォロワーのユーザー
  belongs_to :followed, class_name: 'User'    # フォローされるユーザー
end
