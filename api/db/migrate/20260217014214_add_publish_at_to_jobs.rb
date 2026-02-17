class AddPublishAtToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :publish_at, :datetime
  end
end
