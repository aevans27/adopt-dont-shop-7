class AdminPetsController < ApplicationController
  def approve
    @pet = Pet.find(params[:id])
    @pet.update(adoptable: false)

    application_id = params[:application_id]
    @application = Application.find(application_id)

    redirect_to "/admin/applications/#{@application.id}"
  end
end