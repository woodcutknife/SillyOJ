class AddLogToTestResults < ActiveRecord::Migration
  def change
    add_column :test_results, :log, :text
  end
end
