class RemoveUrlFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :url
  end
end
