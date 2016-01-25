class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :cedula
      t.string :primer_nombre
      t.string :segundo_nombre
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :email
      t.string :telefono
      t.date :fecha_ing
      t.date :fecha_nac
      t.string :slug
      t.belongs_to :family, index:true

      t.timestamps
    end
  end
end
