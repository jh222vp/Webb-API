class CreateResturants < ActiveRecord::Migration
  def change
    create_table :resturants do |t|
    t.belongs_to :position
    t.belongs_to :creator
      
    t.string :name, :limit => 25

    t.string :description, :limit => 254
    t.timestamps
    end
  end
end
