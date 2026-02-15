class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.string :location
      t.integer :employment_type

      t.timestamps
    end
  end
end
