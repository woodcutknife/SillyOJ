class RemoveVisableFromPuzzles < ActiveRecord::Migration
  def change
    remove_column :puzzles, :visable, :boolean
  end
end
