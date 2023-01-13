class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.adults
    self.where('age > ?', 18).order(:name)
  end
end