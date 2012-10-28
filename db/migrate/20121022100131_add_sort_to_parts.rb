class AddSortToParts < ActiveRecord::Migration
  def change
    add_column :parts, :sort, :integer
  end
end
