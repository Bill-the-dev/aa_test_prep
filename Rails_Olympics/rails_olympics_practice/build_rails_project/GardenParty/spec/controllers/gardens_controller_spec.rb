require 'rails_helper'

RSpec.describe GardensController, type: :controller do

    let(:user) do 
        User.create(username: "dynamic_dahlia")
    end

    subject(:garden) do 
        Garden.create!(name: "dahlia's place", size: 120, garden_owner_id: user.id)
    end

    let(:garden2) do 
        Garden.create!(name: "dahlia's daisies", size: 150, garden_owner_id: user.id)
    end

    describe "GET #index" do
        it "renders the index template and sets a @gardens variable for all Gardens in the database" do
            get :index
            #  creating our two gardens in our test database
            garden
            garden2
            fetched_gardens = controller.instance_variable_get(:@gardens)
            expect(fetched_gardens).to eq(Garden.all)
            expect(response).to render_template(:index)
        end
    end

    describe "GET #show" do
        it "renders the show template and sets a @garden variable for the Garden matching the params id" do
            get :show, params: {id: garden.id}
            fetched_garden = controller.instance_variable_get(:@garden)
            expect(fetched_garden).to eq(garden)
            expect(response).to render_template(:show)
        end
    end

    describe "POST #create" do
        context "with valid params" do
            it "redirects to the garden's index page after a garden is created" do
                post :create, params: {
                    garden: {
                        name: "dahlia's garden",
                        size: 120,
                        garden_owner_id: user.id
                    }
                }
                expect(Garden.exists?(:name => "dahlia's garden")).to be true
                expect(response).to redirect_to(gardens_url)
            end
        end

        context "with invalid params" do
            it "renders the new template if a garden does not NOT save to the database" do
                post :create, params: {
                    garden: {
                        name: "",
                        size: 120,
                        garden_owner_id: user.id
                    }
                }

                expect(Garden.exists?(:name => "")).to be false
                expect(response).to render_template(:new)
            end
        end
    end

end
