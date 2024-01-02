class AddNotesToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :notes, :text
  end
end