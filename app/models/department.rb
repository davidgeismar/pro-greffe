# == Schema Information
#
# Table name: departments
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  small_image         :string
#  department_number   :string
#  external_url        :string
#  slug                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  greffes_count   :integer
#  greffes_count :integer
#

class Department < ApplicationRecord
  include SmallImageable

  validates :name, presence: true
  validates :name, uniqueness: true, :case_sensitive => false

  has_many :greffes, dependent: :destroy
  has_many :cities, through: :greffes

  extend FriendlyId
  friendly_id :name, use: :slugged

  def greffes_uniq
    greffeGroup.where('greffes.id in (?)', self.greffes.pluck(:id).uniq)
  end

  def cities_uniq
    City.where('cities.id in (?)', self.cities.pluck(:id).uniq)
  end

  # Find or create an instance from external hash
  def self.find_or_create_from_hash(hash)
    name = hash[:name].to_s
    department = self.find_by(name: name)
    if department.nil?
      department = Department.create(hash.slice(:name, :department_number, :external_url))
    end
    return department
  end


  # If not image got there
  def small_image_wrapper
    if self.small_image?
      return self.small_image_url
    else
      return ""
    end
  end

  def update_counters
    self.update_columns(greffes_count: self.greffes.uniq.count)
  end


end
