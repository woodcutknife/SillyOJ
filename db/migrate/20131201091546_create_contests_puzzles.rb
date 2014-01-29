class CreateContestsPuzzles < ActiveRecord::Migration
  def change
    create_table :contests_puzzles, id: false do |t|
      t.belongs_to :contest, index: true
      t.belongs_to :puzzle, index: true

      # t.timestamps
    end
  end
end
