require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
        it "renders the new template" do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do
        context "with valid params" do
            it "redirects to the garden index page after a user is created" do
                post :create, params: {
                    user: {
                        username: "Farm4Life",
                    }
                }
                expect(User.exists?(:username => "Farm4Life")).to be true
                expect(response).to redirect_to(gardens_url)
            end
        end

        context "with invalid params" do
            it "renders the new template if a user cannot be created" do
                post :create, params: {
                    user: {
                        username: "",
                    }
                }
                expect(User.exists?(:username => "")).to be false
                expect(response).to render_template(:new)
            end
        end
    end
end
