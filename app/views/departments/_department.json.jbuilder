json.extract! department, :id, :name, :description, :small_image, :department_number, :external_url, :slug, :created_at, :updated_at
json.url department_url(department, format: :json)
