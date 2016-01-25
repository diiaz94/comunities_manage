class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.belongs_to :type_request
    	t.belongs_to :status_request
    	t.belongs_to :comunity
    	t.belongs_to :profile
    	t.string :slug
    	t.timestamps
    end
  end
end
