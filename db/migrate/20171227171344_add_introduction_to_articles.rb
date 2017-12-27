class AddIntroductionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :introduction, :text
    add_column :articles, :description, :text

  end
end
