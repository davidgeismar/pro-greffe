
namespace :departments do
  desc 'link greffes to their departments'
  task link_to_greffes: :environment do
    Greffe.all.each do |greffe|
      dept_num = greffe.zip_code[0..1].to_i
      department = Department.where(department_number: dept_num).first
      if department
        greffe.department_id = department.id
        greffe.save!
      end
    end
  end
end
