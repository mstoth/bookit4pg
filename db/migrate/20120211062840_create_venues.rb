class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :contact
      t.string :phone
      t.string :email
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :budget
      t.string :vpic_file_name
      t.string :vpic_content_type
      t.integer :vpic_file_size
      t.datetime :vpic_updated_at
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
