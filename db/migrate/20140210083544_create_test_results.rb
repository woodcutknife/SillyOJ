class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.string :result
      t.float :score
      t.integer :time_cost
      t.integer :memory_cost

      t.timestamps
    end
  end
end
