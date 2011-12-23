class AddWordsDates < ActiveRecord::Migration
  def self.up
    add_column :words, :created_at, :datetime, :null => false
    add_column :words, :updated_at, :datetime, :null => false
  end

  def self.down
    remove_column :words, :created_at
    remove_column :words, :updated_at
  end
end
