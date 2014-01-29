class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name
      t.text :description
      t.text :rendered_description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
