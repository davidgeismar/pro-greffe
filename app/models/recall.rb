# == Schema Information
#
# Table name: recalls
#
#  id          :integer          not null, primary key
#  phone       :string
#  recall_date :datetime
#  recall_now  :boolean
#  reason      :text
#  origin      :string
#  recall_sent :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Recall < ApplicationRecord
  validates :phone, presence: true

  after_create :send_treatment_center

  # Callback to create the recall in the treatment center
  def send_treatment_center
    require 'rest-client'
    result = RestClient.post 'https://www.bankizy.com/api/v1/recalls/oubound_recall_create', {phone: self.phone, recall_date: self.recall_date, reason: self.reason, origin: "greffe Sans Frais"}
  end

  def self.test
    require 'rest-client'
    result = RestClient.post 'https://www.bankizy.com/api/v1/recalls/oubound_recall_create', {phone: "0677273409", recall_date: Time.zone.now, reason: "TEST LOUIS", origin: "greffe Sans Frais"}
  end

end
