class CreateTypeRequests < ActiveRecord::Migration
  def change
    create_table :type_requests do |t|
      t.string :nombre
      t.text :formato
      t.string :slug
      t.timestamps
    end
  end
end
