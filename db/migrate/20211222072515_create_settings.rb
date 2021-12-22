class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.belongs_to :user

      t.string :s1
      t.string :s2
      t.string :s3
      t.timestamps
    end
  end
end
