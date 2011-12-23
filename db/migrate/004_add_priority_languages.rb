class AddPriorityLanguages < ActiveRecord::Migration
  def self.up
    add_column :words, :priority, :integer
    add_column :words, :language_id, :integer
    
    create_table :languages do |t|
      t.string :language
    end
  end

  def self.down
    remove_column :words, :priority
    remove_column :words, :language_id
    drop_table :languages
  end
end
