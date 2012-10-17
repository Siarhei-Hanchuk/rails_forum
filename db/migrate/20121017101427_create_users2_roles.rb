class CreateUsers2Roles < ActiveRecord::Migration
  def change
    create_table :users2_roles do |t|
      t.references :user
      t.reference :role

      t.timestamps
    end
    add_index :users2_roles, :user_id
  end
end
