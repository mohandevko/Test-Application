class CreateUserVenues < ActiveRecord::Migration
  def change
    create_table :user_venues do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :city
      t.string :state
      t.string :country
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end
