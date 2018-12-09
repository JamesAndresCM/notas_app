class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.string :description
      t.string :img
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :notes, [:user_id, :title], unique: true
  end
end
