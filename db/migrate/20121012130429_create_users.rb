class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :pass
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
