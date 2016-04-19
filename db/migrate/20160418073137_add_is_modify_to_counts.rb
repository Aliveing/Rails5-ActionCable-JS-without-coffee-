class AddIsModifyToCounts < ActiveRecord::Migration
  def change
    add_column :counts, :is_modify, :boolean, :default => false
  end
end
