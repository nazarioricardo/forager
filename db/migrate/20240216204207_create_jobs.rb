class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :company, null: false
      t.string :role, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :resume, foreign_key: true
      t.references :letter, foreign_key: true
      t.integer :status
      t.string :link

      t.timestamps
    end
  end
end
