class AddSexoToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :sexo, :boolean
  end
end
