class AddAdminCheckToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :admin_check, :boolean
  end
end
