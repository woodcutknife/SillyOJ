class AddStartedEndedFlagToContests < ActiveRecord::Migration
  def change
    add_column :contests, :started, :boolean
    add_column :contests, :ended, :boolean
  end
end
