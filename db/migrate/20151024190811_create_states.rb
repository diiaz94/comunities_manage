class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :nombre
      t.string :slug
      t.timestamps
    end
  end
end
