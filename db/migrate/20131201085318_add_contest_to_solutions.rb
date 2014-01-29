class AddContestToSolutions < ActiveRecord::Migration
  def change
    add_reference :solutions, :contest, index: true
  end
end
