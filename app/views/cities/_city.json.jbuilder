json.extract! city, :id, :name, :description, :small_image, :zipcode, :external_url, :slug, :department_id, :created_at, :updated_at
json.url city_url(city, format: :json)
