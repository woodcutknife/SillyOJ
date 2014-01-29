class CreateContestsHackers < ActiveRecord::Migration
  def change
    create_table :contests_hackers, id: false do |t|
      t.belongs_to :contest, index: true
      t.belongs_to :hacker, index: true
    end
  end
end
