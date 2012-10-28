class AddAvaColumnToUser < ActiveRecord::Migration
  def up
  	add_column :users, :ava, :string
  end

  def down
  	remove_column :users, :ava
  end
end
