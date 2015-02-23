class DropFkInTags < ActiveRecord::Migration
  def change
    remove_column :tags, :resturantID
  end
end
