class AddUserToJobs < ActiveRecord::Migration[7.1]
  def change
    add_reference :jobs, :user, null: false, foreign_key: true
  end
end
