class CreateLetters < ActiveRecord::Migration[7.1]
  def change
    create_table :letters do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.string :google_drive_file_id, null: false

      t.timestamps
    end
  end
end
