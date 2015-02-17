class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :position_id
      t.integer :creator_id
      t.timestamps
    end
  end
end
