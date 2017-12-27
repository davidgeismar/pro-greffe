# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def find_or_create_city(coordinates, name, zip_code, department)
  result = Geocoder.search(coordinates).first
  if result
    city_name = result.city
    zipcode = result.postal_code
  else
    city_name = name
    zipcode = zip_code
  end
  city = City.find_by(name: city_name)
  if city.nil?
    city = City.create(name: city_name, zipcode: zipcode, department_id: department.id)
  end
  return city
end

Administrator.create(email: 'admin@bankizy.com', password: 'password', password_confirmation: 'password')

departments_file = File.read(Rails.root.join('app', 'assets','data', 'departments.json'))
departments = JSON.parse(departments_file)
#creating departments
departments.each do |department|
  Department.create!({
      name: department['name'],
      description: department['description'],
      department_number: department['department_number'].to_i,
      slug: department['slug']
  })
end
file = File.read(Rails.root.join('app', 'assets','data', 'greffes.json'))
greffes = JSON.parse(file)

# looping on greffes
greffes.each do |greffe|
  location = greffe['coordGps'].split(',') if greffe['coordGps']
  lat = location.first.to_f if location.present?
  long = location.last.to_f if location.present?
  address = greffe['adresse']['lignes']
  dept_num = greffe['adresse']['codePostal'][0..1].to_i

  # cas particuliers
  #basse corse
  if dept_num == 20
    department = Department.where(name: "2A Corse du sud").first
  #outremer
  elsif dept_num == 97
    dept_num = reffe['adresse']['codePostal'][0..2].to_i
    department = Department.where(department_number: dept_num).first
  else
    department = Department.where(department_number: dept_num).first
  end

  #creating cities
  city = find_or_create_city(greffe['coordGps'], greffe['nom'], greffe['adresse']['codePostal'], department)

  #creating greffe
  Greffe.create!({
    number: greffe['numero'],
    name: greffe['nom'],
    scrap_coordinates: greffe['coordGps'],
    latitude: lat,
    longitude: long,
    scrap_address: greffe['adresse']['lignes'],
    address: greffe['adresse']['lignes'].join(" "),
    zip_code: greffe['adresse']['codePostal'],
    phone: greffe['telephone'],
    fax: greffe['fax'],
    website_url: greffe['siteInternetUrl'],
    schedule: greffe['horaires'],
    clerks: greffe['greffiers'],
    tribunal_type: greffe['typeTribunal'],
    scrap_data: greffe,
    department_id: department.id,
    city_id: city.id
  })
end
