class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :title
      t.datetime :date
      t.decimal :price
      t.float :lat
      t.float :lng
      t.integer :venue_id
      t.integer :group_id
      t.string :webpage
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.boolean :offer
      t.string :genre

      t.timestamps
    end
  end
end
