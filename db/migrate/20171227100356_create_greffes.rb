class CreateGreffes < ActiveRecord::Migration[5.1]
  def change
    create_table :greffes do |t|
      t.string :number
      t.string :name
      t.string :scrap_coordinates
      t.float :latitude
      t.float :longitude
      t.text :scrap_address, array: true, default: []
      t.text   :address
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :website_url
      t.text   :schedule
      t.text :clerks, array: true, default: []
      t.string :tribunal_type
      t.string :monday_hours
      t.string :tuesday_hours
      t.string :wednesday_hours
      t.string :thursday_hours
      t.string :friday_hours
      t.string :saturday_hours
      t.string :sunday_hours
      t.string :slug
      t.integer :priority_order
      t.json :scrap_data
      t.timestamps
    end
  end
end



# create_table :greffes do |t|
#   t.references :department, foreign_key: true
#   t.references :greffe, foreign_key: true
#   t.string :name
#   t.text :description
#   t.text :scrap_address
#   t.text :geo_address
#   t.string :city_name
#   t.float :latitude
#   t.float :longitude
#   t.string :website_url
#   t.string :phone
#   t.string :greffe_code
#   t.string :guichet_code
#   t.string :monday_hours
#   t.string :tuesday_hours
#   t.string :wednesday_hours
#   t.string :thursday_hours
#   t.string :friday_hours
#   t.string :saturday_hours
#   t.string :sunday_hours
#   t.string :slug
#   t.integer :priority_order
#
#   t.timestamps
