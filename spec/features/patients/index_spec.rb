require 'rails_helper'

RSpec.describe 'The patient index page', type: :feature do

  let!(:hospital_1) { Hospital.create!(name: "Grey Sloan") }
  let!(:doctor_1) { hospital_1.doctors.create!(name: "George", specialty: "Emergency Medicine", university: "Harvard") }
  let!(:doctor_2) { hospital_1.doctors.create!(name: "Mer", specialty: "General", university: "John Hopkins") }
  let!(:patient_1) { doctor_1.patients.create!(name: "Tim", age: 8) }
  let!(:patient_2) { doctor_1.patients.create!(name: "Joan", age: 32) }
  let!(:patient_3) { doctor_1.patients.create!(name: "Bob", age: 54) }
  let!(:patient_4) { doctor_2.patients.create!(name: "Tina", age: 18) }
  let!(:patient_5) { doctor_2.patients.create!(name: "Bill", age: 19) }
  let!(:doctor_patient_1) { DoctorPatient.create!(doctor: doctor_2, patient: patient_1) }
  let!(:doctor_patient_2) { DoctorPatient.create!(doctor: doctor_2, patient: patient_2) }
  let!(:doctor_patient_3) { DoctorPatient.create!(doctor: doctor_2, patient: patient_3) }
    
  describe 'when a user visits the patient index page' do
    it 'displays all patients whose age is greater than 18' do
      visit patients_path

      expect(page).to have_content "#{patient_2.name}"
      expect(page).to have_content "#{patient_3.name}"
      expect(page).to have_content "#{patient_5.name}"
      expect(page).to_not have_content "#{patient_1.name}"
      expect(page).to_not have_content "#{patient_4.name}"
    end

    it 'displays the names in alphabetical order' do
      visit patients_path
      
      expect(patient_5.name).to appear_before patient_3.name
      expect(patient_3.name).to appear_before patient_2.name
    end
  end
end