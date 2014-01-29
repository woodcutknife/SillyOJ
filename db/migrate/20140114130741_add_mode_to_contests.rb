class AddModeToContests < ActiveRecord::Migration
  def change
    add_column :contests, :mode, :string
  end
end
