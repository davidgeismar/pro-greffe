# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  include PaginateSearch
  self.abstract_class = true

end
