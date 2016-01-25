class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :slug
      t.belongs_to :job, index:true
      t.belongs_to :comunity, index:true
      t.belongs_to :profile, index:true
      t.timestamps
    end
  end
end
