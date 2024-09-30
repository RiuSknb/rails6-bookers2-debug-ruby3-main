class Relationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

  end
end
