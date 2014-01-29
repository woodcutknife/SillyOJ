class AddLanguageLastUseToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :language_last_use, :string
  end
end
