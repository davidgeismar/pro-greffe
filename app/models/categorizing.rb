# == Schema Information
#
# Table name: categorizings
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  categorizable_type :string
#  categorizable_id   :integer
#  rank_order         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Categorizing < ApplicationRecord
  belongs_to :category
  belongs_to :categorizable, polymorphic: true

  validates :category_id, presence: true
  validates :category_id, :uniqueness => {:scope => [:categorizable_type, :categorizable_id]}

end
