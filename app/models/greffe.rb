class Greffe < ApplicationRecord
  include SmallImageable
  include BigImageable
  belongs_to :department
  belongs_to :city

  has_many :recommandations, dependent: :destroy

  geocoded_by :scrap_address
  reverse_geocoded_by :latitude, :longitude

  validates :name, presence: true
  validates :name, uniqueness: true, :case_sensitive => false

  # Create the city association
  # before_validation :create_city_association

  extend FriendlyId
  friendly_id :name, use: :slugged

  def big_image_wrapper
    if self.big_image?
      return self.big_image_url
    else
      return ActionController::Base.helpers.asset_path("agence-bancaire-photo.png", :digest => false)
    end
  end
  # Get all departments where selection is present
  def self.departments
    Department.where('departments.id IN (?)', self.pluck(:department_id).uniq)
  end



  # Get all departments where selection is present
  def self.cities
    City.where('cities.id IN (?)', self.pluck(:city_id).uniq)
  end

# # Find or create an instance from external hash
# def self.find_or_create_from_hash(hash)
#   name = hash[:name].to_s
#   greffe = self.find_by(name: name)
#   if greffe.nil?
#     greffe = greffeAgency.create(hash)
#   end
#   return greffe
# end

  # Find or create the city instance linked to the greffe agency
  def find_or_create_city
    result = Geocoder.search(self.scrap_coordinates).first
    if result
      city_name = result.city
      zipcode = result.postal_code
    else
      city_name = self.name
      zipcode = self.zip_code
    end
    city = City.find_by(name: city_name)
    if city.nil?
      city = City.create(name: city_name, zipcode: zipcode, department_id: self.department_id)
    end
    return city
  end

  # Create the cities based on the database of greffe
  def generate_city_association
    city = self.find_or_create_city
    self.update_columns(city_id: city.id)
  end

  # The callback when the greffe agency is created
  def create_city_association
    city = self.find_or_create_city
    self.city_id = city.id
  end

  # # Wrapper for the phone of a greffe agency
  # def phone_wrapper
  #   if self.phone.blank?
  #     return self.greffe.phone
  #   end
  #   return self.phone
  # end

# # Wrapper for the website url
# def website_url_wrapper
#   if self.website_url.blank?
#     return self.greffe.website_url
#   end
#   return self.website_url
# end

# If not image got there
# def small_image_wrapper
#     return self.greffe.small_image_wrapper
# end

# Complete address for the agency
def complete_address
  self.address + " - " + self.city.name
end

# # Get all the agencies near this ones
def near_greffes
  return Greffe.search_near_geopoint(self.latitude, self.longitude, zipcode = nil, radius = 2.5)
end

def phone_wrapper
  return self.phone
end
# # Get all the agencies near this ones
# def near_greffes_from_greffe
#   return greffeAgency.search_near_geopoint(self.latitude, self.longitude, zipcode = nil, radius = 2).where('greffes.greffe_id = ?', self.greffe_id)
# end

# Get all the agencies near this ones not from the same greffe group
# def near_greffes_other_greffe
#   return greffeAgency.search_near_geopoint(self.latitude, self.longitude, zipcode = nil, radius = 2).where('greffes.greffe_id != ?', self.greffe_id)
# end

# Distance from another greffes
# def distance_from(greffe)
#   return self.distance_to([greffe.latitude, greffe.longitude], :km)
# end

#Class method to get all the elements around a coordinates
def self.search_near_geopoint(latitude, longitude, zipcode = nil, radius = 2.5)
  ids_near = self.near([latitude, longitude], radius, units: :km,  order: 'name').pluck(:id).uniq
  return self.where('greffes.id IN (?)', ids_near)
end
end
