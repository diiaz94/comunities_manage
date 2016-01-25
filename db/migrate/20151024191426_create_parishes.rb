class CreateParishes < ActiveRecord::Migration
  def change
    create_table :parishes do |t|
      t.string :nombre
      t.string :slug
      t.belongs_to :town, index:true
      t.timestamps
    end
  end
end
