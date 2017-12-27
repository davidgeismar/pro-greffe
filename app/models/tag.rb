# == Schema Information
#
# Table name: tags
#
#  id               :integer          not null, primary key
#  name             :string
#  research_name    :string
#  description      :text
#  popularity_order :integer
#  small_image      :string
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# Class that manage the tag to tag all taggable instance
class Tag < ApplicationRecord
  include SmallImageable
  validates :name, presence: true

  has_many :taggings, dependent: :destroy

  # All the important taggable instances
  has_many :articles, through: :taggings, source: :taggable, source_type: "Article"
  has_many :media, through: :taggings, source: :taggable, source_type: "Meidum"

  ##-- Callbacks -------------------
  before_validation :sanitize_name
  after_save :update_research_name, if: :name_changed?


  # Class method that handles the sanitization of the tags
  def self.sanitize_name(name)
    return name.to_s.strip.downcase
  end

  # For searching
  def self.filter_search(attributes)
    attributes.to_unsafe_h.inject(self) do |scope, (key, value)|
      # return scope.scoped if value.blank?
      if value.blank?
        scope.all
      else
        case key.to_sym

        when :name
          name = value.to_s.upcase
          scope.where("#{table_name}.name ILIKE ?", "%#{name}%")

        when :order # order=field-(ASC|DESC)
          attribute, order = value.split('-')
          scope.order("#{table_name}.#{attribute} #{order}")
        else # unknown key (do nothing or raise error, as you prefer to)
          scope.all
        end

      end
    end
  end

  private

 # Callbacks for the research_name. Research name is a field that try to ease the process of research
 def update_research_name
   res_name = I18n.transliterate(Tag.sanitize_name(self.name)).to_s
   self.update_column(:research_name, res_name)
 end

 # Callback to sanitize the tag name to avoid repetition
 def sanitize_name
   self.name = Tag.sanitize_name(self.name)
 end
end
