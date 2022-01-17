require 'rails_helper'

RSpec.describe FlowersController, type: :controller do
    let(:user) do 
        User.create(username: "dynamic_dahlia")
    end

    let(:garden) do 
        Garden.create(name: "dally's place", size: 100, garden_owner_id: user.id)
    end

    describe "POST #create" do
        context "with valid params" do

            it "redirects to the garden's show page after a flower is created" do
                post :create, params: {
                    flower: {
                        flower_type: "iris",
                        gardener_id: user.id,
                        garden_id: garden.id
                    }
                }
                expect(Flower.exists?(:flower_type => "iris")).to be true
                expect(response).to redirect_to(garden_url(garden.id))
            end
        end

        context "with invalid params" do
            it "redirects to the garden's show page if flower is NOT created" do
                post :create, params: {
                    flower: {
                        flower_type: "",
                        gardener_id: user.id,
                        garden_id: garden.id
                    }
                }
                expect(Flower.exists?(:flower_type => "")).to be false
                expect(response).to redirect_to(garden_url(garden.id))
            end
        end
    end

    describe "DELETE #destroy" do
            
        it "removes the flower from the database and redirects to the garden's show page" do
            flower = Flower.create!(flower_type: "Rose", gardener_id: user.id, garden_id: garden.id)
            delete :destroy, params: {id: flower.id}
            expect(Flower.exists?(flower.id)).to be false
            expect(response).to redirect_to(garden_url(garden.id))
        end
    end
end
