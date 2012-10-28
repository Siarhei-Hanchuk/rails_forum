class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
