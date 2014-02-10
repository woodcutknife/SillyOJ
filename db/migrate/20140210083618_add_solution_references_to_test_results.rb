class AddSolutionReferencesToTestResults < ActiveRecord::Migration
  def change
    add_reference :test_results, :solution, index: true
  end
end
