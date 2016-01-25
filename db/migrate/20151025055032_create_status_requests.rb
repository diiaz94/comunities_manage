class CreateStatusRequests < ActiveRecord::Migration
  def change
    create_table :status_requests do |t|
      t.string :nombre
	  t.string :slug
      t.timestamps
    end
  end
end
