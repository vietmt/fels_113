class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :learned, default: false

      t.timestamps null: false
    end
  end
end
