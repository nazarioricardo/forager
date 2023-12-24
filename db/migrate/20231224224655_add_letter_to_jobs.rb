class AddLetterToJobs < ActiveRecord::Migration[7.1]
  def change
    add_reference :jobs, :letter, null: false, foreign_key: true
  end
end
