# == Schema Information
#
# Table name: recommandations
#
#  id             :integer          not null, primary key
#  greffe_id :integer
#  email          :string
#  author         :string
#  rating         :integer
#  comment        :text
#  visible        :boolean
#  admin_check    :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Recommandation < ApplicationRecord
  belongs_to :greffe

  validates :email, presence: true
  validates :author, presence: true
  validates :comment, presence: true

  
end
