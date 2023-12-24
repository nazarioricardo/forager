class ChangeLetterIdInJobs < ActiveRecord::Migration[7.1]
  def change
    change_column_null :jobs, :letter_id, true
  end
end
