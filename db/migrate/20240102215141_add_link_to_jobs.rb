class AddLinkToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :link, :string
  end
end