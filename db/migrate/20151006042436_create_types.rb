class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :nombre
      t.text :descripcion
      t.string :slug

      t.timestamps
    end
  end
end
