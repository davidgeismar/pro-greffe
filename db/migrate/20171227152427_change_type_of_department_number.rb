class ChangeTypeOfDepartmentNumber < ActiveRecord::Migration[5.1]
  def change
    change_column :departments, :department_number, 'integer USING CAST(department_number AS integer)'
  end
end
