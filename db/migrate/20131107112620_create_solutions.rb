class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :code
      t.text :rendered_code
      t.string :language
      t.integer :time_cost
      t.integer :memory_cost
      t.string :result
      t.references :hacker, index: true
      t.references :puzzle, index: true

      t.timestamps
    end
  end
end
