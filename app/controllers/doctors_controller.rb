class DoctorsController < ApplicationController
  before_action :find_doctor, only: [:show, :update]
  
  def show
  end

  def update
    @doctor_patient = DoctorPatient.find_by(doctor: params[:id], patient: params[:patient_id])
    @doctor_patient.destroy
    redirect_to doctor_path
  end

  private

  def find_doctor
    @doctor = Doctor.find(params[:id])
  end
end