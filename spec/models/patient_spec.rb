require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'relations' do
    it { should have_many :doctor_patients }
    it { should have_many(:doctors).through(:doctor_patients) }
  end

  describe 'class methods' do
    
    let!(:hospital_1) { Hospital.create!(name: "Grey Sloan") }
    let!(:hospital_2) { Hospital.create!(name: "Seaside Health & Wellnesss Center") }
    let!(:doctor_1) { hospital_1.doctors.create!(name: "George", specialty: "Emergency Medicine", university: "Harvard") }
    let!(:doctor_2) { hospital_1.doctors.create!(name: "Mer", specialty: "General", university: "John Hopkins") }
    let!(:doctor_3) { hospital_2.doctors.create!(name: "Miranda", specialty: "General", university: "Stanford") }
    let!(:patient_1) { doctor_1.patients.create!(name: "Tim", age: 8) }
    let!(:patient_2) { doctor_1.patients.create!(name: "Joan", age: 32) }
    let!(:patient_3) { doctor_1.patients.create!(name: "Bob", age: 54) }
    let!(:patient_4) { doctor_2.patients.create!(name: "Tina", age: 18) }
    let!(:patient_5) { doctor_3.patients.create!(name: "Bill", age: 19) }
    let!(:doctor_patient_1) { DoctorPatient.create!(doctor: doctor_2, patient: patient_1) }
    let!(:doctor_patient_2) { DoctorPatient.create!(doctor: doctor_2, patient: patient_2) }
    let!(:doctor_patient_3) { DoctorPatient.create!(doctor: doctor_2, patient: patient_3) }
    
    describe 'adults' do
      it 'returns all patients whose age is greater than 18, sorted alphabetically' do
        expect(Patient.adults).to eq [patient_5, patient_3, patient_2]
      end
    end
  end
end