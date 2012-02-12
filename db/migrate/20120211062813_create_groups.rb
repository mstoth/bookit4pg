class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.string :contact
      t.string :phone
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.string :picture_file_name
      t.string :picture_content_type
      t.datetime :picture_updated_at
      t.integer :picture_file_size
      t.string :website
      t.string :email
      t.boolean :locked
      t.float :latitude
      t.float :longitude
      t.integer :user_id
      
      t.timestamps
    end
  end
end
