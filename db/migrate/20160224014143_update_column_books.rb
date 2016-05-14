class UpdateColumnBooks < ActiveRecord::Migration
  def change
    remove_column :books, :year
  end
end
