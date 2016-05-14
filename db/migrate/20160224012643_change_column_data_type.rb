class ChangeColumnDataType < ActiveRecord::Migration
  def self.up
    change_column :books, :year, :date
  end

  def self.down
    change_column :books, :year, :integer
  end
end
