class RemoveRunningFlagFromContests < ActiveRecord::Migration
  def change
    remove_column :contests, :running, :boolean
  end
end
