class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.date :year
      t.string :isbn
      t.string :image

      t.timestamps null: false
    end
  end
end
