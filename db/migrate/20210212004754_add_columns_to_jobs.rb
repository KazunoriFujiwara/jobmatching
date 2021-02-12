class AddColumnsToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :start_date, :date
    add_column :jobs, :start_time, :time
    add_column :jobs, :end_date, :date
    add_column :jobs, :end_time, :time
    add_column :jobs, :place, :string
  end
end
