class AddDefaultFlagToContests < ActiveRecord::Migration
  def change
    add_column :contests, :default?, :boolean
  end
end
