# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  taggable_type :string
#  taggable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Tagging < ApplicationRecord
  belongs_to :tag, required: true
  belongs_to :taggable, polymorphic: true, required: true

  validates :tag_id, :uniqueness => {:scope => [:taggable_type, :taggable_id]}
end
