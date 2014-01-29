class AddVisableToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :visable, :boolean
  end
end
