class AddSomethingToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :input_format, :text
    add_column :puzzles, :rendered_input_format, :text
    add_column :puzzles, :output_format, :text
    add_column :puzzles, :rendered_output_format, :text
    add_column :puzzles, :sample_input, :text
    add_column :puzzles, :rendered_sample_input, :text
    add_column :puzzles, :sample_output, :text
    add_column :puzzles, :rendered_sample_output, :text
    add_column :puzzles, :hint, :text
    add_column :puzzles, :rendered_hint, :text
  end
end
