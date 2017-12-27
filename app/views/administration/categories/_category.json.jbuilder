json.extract! category, :id, :name, :description, :small_image, :category_type, :visible, :admin_check, :slug, :created_at, :updated_at
json.url category_url(category, format: :json)
