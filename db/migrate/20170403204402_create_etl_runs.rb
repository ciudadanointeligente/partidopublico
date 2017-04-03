class CreateEtlRuns < ActiveRecord::Migration
  def change
    create_table :etl_runs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :job_name
      t.text :results
      t.integer :input_rows

      t.timestamps null: false
    end
  end
end
