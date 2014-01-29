class RemoveDefaultFlagFromContests < ActiveRecord::Migration
  def change
    remove_column :contests, :default?, :boolean
  end
end
