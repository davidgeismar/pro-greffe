json.extract! article, :id, :name, :slug, :description, :introduction, :date, :hero_image, :small_image, :visible, :created_at, :updated_at
json.url article_url(article, format: :json)
