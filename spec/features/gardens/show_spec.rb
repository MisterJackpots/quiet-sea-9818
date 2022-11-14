require 'rails_helper'

RSpec.describe 'the gardens show page' do
  before :each do
    @turing = Garden.create!(name: "Turing Community Garden", organic: true)
    @agritopia = Garden.create!(name: "Agritopia Farm", organic: true)
    @plot1 = @turing.plots.create!(number: 25, size: "Large", direction: "East")
    @plot2 = @turing.plots.create!(number: 87, size: "Small", direction: "West")
    @plot3 = @agritopia.plots.create!(number: 9, size: "Very Large", direction: "North")
    @plot4 = @agritopia.plots.create!(number: 35, size: "Medium", direction: "West")
    @pepper = Plant.create!(name: "Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @potato = Plant.create!(name: "Yukon Gold", description: "Needs colder temps", days_to_harvest: 120)
    @squash = Plant.create!(name: "Yellow Squash", description: "Minimal care required", days_to_harvest: 60)
    @kale = Plant.create!(name: "Dino Kale", description: "Alkaline soil needed", days_to_harvest: 50)
    @tomato = Plant.create!(name: "Beefeater Tomato", description: "Enjoys full sun", days_to_harvest: 75)
    @plotplant1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @kale.id)
    @plotplant2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @tomato.id)
    @plotplant3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @pepper.id)
    @plotplant4 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @tomato.id)
    @plotplant5 = PlotPlant.create!(plot_id: @plot3.id, plant_id: @potato.id)
    @plotplant6 = PlotPlant.create!(plot_id: @plot4.id, plant_id: @squash.id)
  end

  it "displays all the plants grown in the garden's plots" do
    visit garden_path(@turing)

    expect(page).to have_content(@kale.name)
    expect(page).to have_content(@tomato.name)
    expect(page).to have_content(@pepper.name)
    expect(page).to_not have_content(@potato.name)
    expect(page).to_not have_content(@squash.name)
  end

  it 'displays a unique list of plants with no duplicates' do
    visit garden_path(@turing)

    expect(page).to have_content(@tomato.name).once
  end

  it 'only lists plants that take less than 100 days to harvest' do
    visit garden_path(@agritopia)

    expect(page).to have_content(@squash.name)
    expect(page).to_not have_content(@potato.name)
  end
end