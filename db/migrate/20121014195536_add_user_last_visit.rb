class AddUserLastVisit < ActiveRecord::Migration
	def up
		add_column :users, :last_visit, :date
	end

	def down
		remove_column :users, :last_visit
	end
end
