json.extract! recommandation, :id, :greffe_id, :email, :author, :rating, :comment, :visible, :admin_check, :created_at, :updated_at
json.url recommandation_url(recommandation, format: :json)
