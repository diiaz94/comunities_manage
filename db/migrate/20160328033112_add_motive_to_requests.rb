class AddMotiveToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :motive, :string
  end
end
