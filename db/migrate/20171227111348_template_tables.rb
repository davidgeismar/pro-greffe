class TemplateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.text :description
      t.string :small_image
      t.string :department_number
      t.string :external_url
      t.string :slug

      t.timestamps
    end
    create_table :cities do |t|
      t.string :name
      t.text :description
      t.string :small_image
      t.string :zipcode
      t.string :external_url
      t.string :slug
      t.references :department, foreign_key: true

      t.timestamps
    end
    create_table :recommandations do |t|
      t.references :greffe, foreign_key: true
      t.string :email
      t.string :author
      t.integer :rating
      t.text :comment
      t.boolean :visible
      t.boolean :admin_check

      t.timestamps
    end
    create_table :articles do |t|
      t.string :name
      t.string :meta_title
      t.text :small_description
      t.text :meta_description
      t.string :slug
      t.text :content
      t.string :small_image
      t.date :date
      t.string :author
      t.boolean :visible
      t.string :lead_type

      t.timestamps
    end
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.string :small_image
      t.string :category_type
      t.boolean :visible
      t.string :type

      t.timestamps
    end
    create_table :categorizings do |t|
      t.references :category, foreign_key: true
      t.references :categorizable, polymorphic: true
      t.integer :rank_order

      t.timestamps
    end
    create_table :media do |t|
      t.string :name
      t.string :internal_name
      t.text :description
      t.integer :popularity_order
      t.string :medium_kind
      t.string :video_link
      t.string :small_image

      t.timestamps
    end
    create_table :recalls do |t|
      t.string :phone
      t.datetime :recall_date
      t.boolean :recall_now
      t.text :reason
      t.string :origin
      t.boolean :recall_sent
      t.text :reason

      t.timestamps
    end
    create_table :tags do |t|
      t.string :name
      t.string :research_name
      t.text :description
      t.integer :popularity_order
      t.string :slug
      t.string :small_image
      t.timestamps
    end
    create_table :taggings do |t|
      t.references :tag, foreign_key: true
      t.references :taggable, polymorphic: true
    end
    create_table :administrators do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean :is_admin, default: false

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end
    add_index :administrators, :email,                unique: true
    add_index :administrators, :reset_password_token, unique: true
    # add_index :administrators, :confirmation_token,   unique: true
    # add_index :administrators, :unlock_token,         unique: true
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], :unique => true
    add_index :friendly_id_slugs, :sluggable_type

  end
end
