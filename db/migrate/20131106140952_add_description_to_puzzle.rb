class AddDescriptionToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :description, :text
    add_column :puzzles, :rendered_description, :text
  end
end
