class AddResumeToJobs < ActiveRecord::Migration[7.1]
  def change
    add_reference :jobs, :resume, null: false, foreign_key: true
  end
end
