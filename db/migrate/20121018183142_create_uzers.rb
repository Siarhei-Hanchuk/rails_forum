class CreateUzers < ActiveRecord::Migration
  def change
    create_table :uzers do |t|
      t.string :username
      t.string :nickname
      t.string :provider
      t.string :url

      t.timestamps
    end
  end
end
