class PatientsController < ApplicationController
  def index
    @patients = Patient.adults
  end
end