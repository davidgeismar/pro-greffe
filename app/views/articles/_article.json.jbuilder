json.extract! article, :id, :name, :meta_title, :small_description, :meta_description, :slug, :content, :small_image, :date, :author, :visible, :lead_type, :created_at, :updated_at
json.url article_url(article, format: :json)
