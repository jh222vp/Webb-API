class CreateResturantsTags < ActiveRecord::Migration
  def change
    create_table :resturants_tags do |t|
      t.belongs_to :tag
      t.belongs_to :resturant
    end
  end
end
