class CreateUrls < ActiveRecord::Migration
	def change
		create_table :urls do |t|
			t.string :long_url, index: true
			t.string :short_url, index: true
			t.integer :count_short_url, :default => 0
			t.timestamps
		end
	end
end


#why index works faster: http://www.slashroot.in/how-does-indexing-makes-database-faster