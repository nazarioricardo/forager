class ChangeResumeIdInJobs < ActiveRecord::Migration[7.1]
  def change
    change_column_null :jobs, :resume_id, true
  end
end