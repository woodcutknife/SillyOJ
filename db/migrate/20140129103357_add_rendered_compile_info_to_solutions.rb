class AddRenderedCompileInfoToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :rendered_compile_info, :text
  end
end
