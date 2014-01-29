class AddRunningFlagToContests < ActiveRecord::Migration
  def change
    add_column :contests, :running, :boolean
  end
end
