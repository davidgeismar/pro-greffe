# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  name              :string
#  meta_title        :string
#  small_description :text
#  meta_description  :text
#  slug              :string
#  content           :text
#  small_image       :string
#  date              :date
#  author            :string
#  visible           :boolean
#  lead_type         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# Article for the Blog
class Article < ApplicationRecord
  include SmallImageable
  include Categorizable
  include Taggable
  extend FriendlyId

  friendly_id :name, use: :slugged

  # Validations
  validates :name, :small_description, :content,  presence: true
  validates :name, uniqueness: true, :case_sensitive => false
  scope :visible, -> { where.not(visible: false) }


  def self.filter_search(attributes)
    # TODO CHANGE because to _unsafe h permits to inject all the things of attributes
    attributes.to_unsafe_h.inject(self) do |scope, (key, value)|
      # return scope.scoped if value.blank?
      if value.blank?
        scope.all
      else
        case key.to_sym
        when :order # order=field-(ASC|DESC)
          attribute, order = value.split('-')
          scope.order("#{table_name}.#{attribute} #{order}")
        when :name
          name = value.to_s
          scope.where("#{table_name}.#{key} ILIKE ?  ", "%#{name}%")
        else # unknown key (do nothing or raise error, as you prefer to)
          scope.all
        end

      end
    end
  end
end
