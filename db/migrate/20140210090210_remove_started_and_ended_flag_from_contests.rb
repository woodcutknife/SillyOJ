class RemoveStartedAndEndedFlagFromContests < ActiveRecord::Migration
  def change
    remove_column :contests, :started, :boolean
    remove_column :contests, :ended, :boolean
  end
end
