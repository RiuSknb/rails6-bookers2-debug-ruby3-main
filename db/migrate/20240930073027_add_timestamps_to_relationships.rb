class AddTimestampsToRelationships < ActiveRecord::Migration[6.1]
  def change
    change_table :relationships do |t|
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
