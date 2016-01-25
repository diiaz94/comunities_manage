class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :nombre
      t.string :slug
      t.belongs_to :state, index:true
      t.timestamps
    end
  end
end
