class CreateComunities < ActiveRecord::Migration
  def change
    create_table :comunities do |t|
      t.string :rif,            :null => false
      t.string :cod_registro
      t.string :nombre
      t.string :catastro
      t.string :sector
      t.text :direccion
      t.belongs_to :parish, index:true
      t.string :slug
      t.timestamps
    end
    
      add_index :comunities, :rif, unique: true
  end
end
