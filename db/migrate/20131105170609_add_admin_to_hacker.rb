class AddAdminToHacker < ActiveRecord::Migration
  def change
    add_column :hackers, :admin, :boolean
  end
end
