class DropColumnInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :status
  end
end
