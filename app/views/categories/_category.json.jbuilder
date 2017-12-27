json.extract! category, :id, :name, :description, :slug, :small_image, :category_type, :visible, :type, :created_at, :updated_at
json.url category_url(category, format: :json)
