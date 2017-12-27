# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  slug          :string
#  small_image   :string
#  category_type :string
#  visible       :boolean
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Category < ApplicationRecord
  include SmallImageable
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :name, :uniqueness => {:scope => [:type]}, :case_sensitive => false

  has_many :categorizings, dependent: :destroy
  has_many :categorizables, through: :categorizings
  has_many :articles, through: :categorizings, source: :categorizable, source_type: "Article"

#   scope :review_categories, -> { where(type: 'ReviewCategory') }
# scope :contact_categories, -> { where(type: 'ContactCategory') }
# scope :explanation_categories, -> { where(type: 'ExplanationCategory') }
# scope :article_categories, -> { where(type: 'ArticleCategory') }
# scope :lexicon_categories, -> { where(type: 'LexiconCategory') }
# scope :organization_categories, -> { where(type: 'OrganizationCategory') }
# scope :greffe_categories, -> { where(type: 'greffeCategory') }
# scope :greffe_form_result_categories, -> { where(type: 'greffeFormResultCategory') }
# scope :saving_livret_categories, -> { where(type: 'SavingLivretCategory') }
# scope :life_insurance_categories, -> { where(type: 'LifeInsuranceCategory') }
# scope :greffeing_actor_categories, -> { where(type: 'greffeingActorCategory') }
# All the categories types
def self.types
  if Rails.env.development?
    return [ "ArticleCategory"]
  else
    return self.descendants.map{|c| c.name}
  end
end

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
      when :type
        type = value.to_s
        scope.where("#{table_name}.#{key} ILIKE ?  ", "%#{type}%")
      else # unknown key (do nothing or raise error, as you prefer to)
        scope.all
      end

    end
  end
end

# Wrapper for the image and the default
# def small_image_wrapper
#   if self.small_image?
#     return self.small_image_url
#   else
#     return self.default_image_url
#   end
# end
#
# # Default per category
# def default_image_url
#   if self.type == "greffeCategory"
#     return "icones/icones_greffe.png"
#   elsif self.type == "OrganizationCategory"
#     return "icones/icones_greffe.png"
#   else
#     return "icones/icones_greffe.png"
#   end
# end
#
# ## SEARCHING
#
#   # For searching
#   def self.filter_search(attributes)
#     attributes.to_unsafe_h.inject(self) do |scope, (key, value)|
#       # return scope.scoped if value.blank?
#       if value.blank?
#         scope.all
#       else
#         case key.to_sym
#
#         when :name
#           name = value.to_s.upcase
#           scope.where("#{table_name}.name ILIKE ?", "%#{name}%")
#
#         when :type
#           name = value.to_s
#           scope.where("#{table_name}.type ILIKE ?", "%#{name}%")
#
#         when :order # order=field-(ASC|DESC)
#           attribute, order = value.split('-')
#           scope.order("#{table_name}.#{attribute} #{order}")
#         else # unknown key (do nothing or raise error, as you prefer to)
#           scope.all
#         end
#
#       end
#     end
#   end
end
