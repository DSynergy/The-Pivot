class ChangeRetiredToRetired < ActiveRecord::Migration
  def change
    rename_column :items, :retired?, :retired
  end
end
