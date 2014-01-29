class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :title
      t.integer :time_limit
      t.integer :memory_limit

      t.timestamps
    end
  end
end
