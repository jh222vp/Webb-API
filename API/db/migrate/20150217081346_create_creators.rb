class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :fname
      t.string :lname
      t.timestamps
    end
  end
end
