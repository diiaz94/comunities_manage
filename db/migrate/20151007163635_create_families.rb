class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :nombre_casa
      t.string :numero_casa,			:null => false
      t.string :telefono
      t.text :direccion
      t.string :slug
      t.belongs_to :comunity, index:true
      t.timestamps
    end

    add_index :families, :numero_casa, unique: true
  end
end
