class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_venue_id
      t.string :title
      t.attachment :photo
      t.string :credit
      t.timestamps
    end
  end
end
