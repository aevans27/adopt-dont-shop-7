class AdminPetsController < ApplicationController
  def approve
    @pet = Pet.find(params[:id])
    @pet.update(adoptable: false)

    @application = Application.find(params[:id])

    redirect_to "/admin/applications/#{@application.id}"
  end
end