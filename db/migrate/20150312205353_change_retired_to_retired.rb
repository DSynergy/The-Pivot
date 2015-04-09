class ChangeRetiredToRetired < ActiveRecord::Migration
  def change
    rename_column :listings, :retired?, :retired
  end
end
