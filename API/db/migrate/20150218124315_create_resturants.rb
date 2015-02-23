class CreateResturants < ActiveRecord::Migration
  def change
    create_table :resturants do |t|

      t.timestamps
    end
  end
end
