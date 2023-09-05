require "rails_helper"

RSpec.describe "the admin applications show page" do
  it "displays all pets within the application" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_1.id)
    application.add_pet(pet_2.id)

    visit "/admin/applications/#{application.id}"
    

    expect(page).to have_content("Lobster")
    expect(page).to have_content("Bacon")
  end

  it "adds a button for the admin to approve the pet" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_1.id)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_content("Approve")
  end

  it "allows us to approve the pet, and remove the option for approval" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_1.id)

    visit "/admin/applications/#{application.id}"
    click_button('Approve')

    save_and_open_page

    expect(page).to have_content('Approved')
  end

  it "changes the status of the pet to not adoptable" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_1.id)

    visit "/admin/applications/#{application.id}"
    click_button('Approve')

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("false")
  end


end