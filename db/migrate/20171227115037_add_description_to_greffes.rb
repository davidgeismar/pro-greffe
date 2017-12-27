class AddDescriptionToGreffes < ActiveRecord::Migration[5.1]
  def change
    add_column :greffes, :description, :text
  end
end
