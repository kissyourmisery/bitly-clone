class CreateAgain < ActiveRecord::Migration
	def change
		add_column :urls, :count_short_url, :integer, :default => 0
	end
end
