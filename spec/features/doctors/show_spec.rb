require 'rails_helper'

RSpec.describe 'The doctor show page', type: :feature do
  describe 'when a user visits the doctor show page' do
    
    let!(:hospital_1) { Hospital.create!(name: "Grey Sloan") }
    let!(:doctor_1) { hospital_1.doctors.create!(name: "George", specialty: "Emergency Medicine", university: "Harvard") }
    let!(:patient_1) { doctor_1.patients.create!(name: "Tim", age: 8) }
    let!(:patient_2) { doctor_1.patients.create!(name: "Joan", age: 32) }
    let!(:patient_3) { doctor_1.patients.create!(name: "Bob", age: 54) }

    it 'displays the doctors name, specialty, university and hospital' do
      visit doctor_path(doctor_1)

      expect(page).to have_content "Name: #{doctor_1.name}"
      expect(page).to have_content "Specialty: #{doctor_1.specialty}"
      expect(page).to have_content "University: #{doctor_1.university}"
      expect(page).to have_content "Hospital: #{doctor_1.hospital.name}"
    end

    it 'displays the name of all patients a doctor has' do
      visit doctor_path(doctor_1)

      within("#patients") do
        expect(page).to have_content "#{patient_1.name}"
        expect(page).to have_content "#{patient_2.name}"
        expect(page).to have_content "#{patient_3.name}"
      end
    end

    describe "Remove Patients" do
      it 'has a button next to each patient to remove that patient from the doctor' do
        visit doctor_path(doctor_1)

        within("#patients") do
          expect(page).to have_button "Remove Patient", count: doctor_1.patients.length
        end
      end
    end
  end
end