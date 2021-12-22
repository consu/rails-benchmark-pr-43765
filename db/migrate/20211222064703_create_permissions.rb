class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.belongs_to :user

      t.string :p1
      t.string :p2
      t.string :p3

      t.timestamps
    end
  end
end
