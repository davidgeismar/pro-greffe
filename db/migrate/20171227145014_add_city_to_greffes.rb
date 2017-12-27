class AddCityToGreffes < ActiveRecord::Migration[5.1]
  def change
    add_reference :greffes, :city, foreign_key: true
  end
end
