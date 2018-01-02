Rails.application.routes.draw do



  # Main page
  root 'home#main'
  # Public Pages
  get 'home/legal_mention'
  get 'les-greffes-sans-frais', to: "home#recommended_greffes", as: :home_recommended_greffes
  get 'comment-changer-de-greffe', to: "home#change_greffe_procedure", as: :home_change_greffe_procedure
  get 'frais-bancaires', to: "home#greffe_fee", as: :home_greffe_fee
  get 'negocier-ses-frais-bancaires', to: "home#fee_negociation", as: :home_fee_negociation

  # Sitemap routes
  get 'sitemap/show'

  # Ressources
  resources :recalls
  get 'book-a-meeting', to: 'recalls#book_a_meeting_static'

  devise_for :administrators

  # Resources for common models
  resources :greffes, path: 'greffes'
  resources :departments, path: 'greffes-departement' do
    resources :greffes, only: [:show], path: 'greffes'
  end
  resources :cities, path: "greffes-ville" do
    resources :greffes, only: [:show], path: 'greffes'
  end

  # BLOG
  resources :articles, path: ''
  # Categories
  resources :categories
  # Recommandations
  resources :recommandations do
    collection do
      post "public_create"
    end
  end
  # Media attachment
  resources :media do
    collection do
      post 'create_image_attachment'
    end
  end

  # Redirection Feature
  get 'redirection/go'

  # Administration Dashboard
  namespace :administration do
    get 'dashboard'
    resources :categories
    resources :articles
    resources :greffes, path: 'greffes'
    resources :tags do
      collection do
        get 'autocomplete'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
