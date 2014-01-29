class AddCompileInfoToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :compile_info, :text
  end
end
