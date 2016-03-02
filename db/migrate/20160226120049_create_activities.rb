class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :state, default: 0
      t.integer :target_id

      t.timestamps null: false
    end
  end
end
