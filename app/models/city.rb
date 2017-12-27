# == Schema Information
#
# Table name: cities
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  small_image   :string
#  zipcode       :string
#  external_url  :string
#  slug          :string
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Class that will represent the city into which the greffe is
class City < ApplicationRecord
  belongs_to :department, optional: true

  validates :name, presence: true
  validates :name, uniqueness: true, :case_sensitive => false
  has_many :greffes
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  def greffes_uniq
    greffeGroup.where('greffes.id in (?)', self.greffes.pluck(:id).uniq)
  end

end
