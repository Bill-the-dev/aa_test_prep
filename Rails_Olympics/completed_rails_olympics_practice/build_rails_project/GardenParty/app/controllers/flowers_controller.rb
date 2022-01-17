class FlowersController < ApplicationController
    
    def create
        new_flower = Flower.create(new_flower_params)

        if new_flower.save
            redirect_to garden_url(new_flower_params[:garden_id]) 

            # redirect_to garden_url(params[:flower][:garden_id])
            # redirect_to new_flower.garden
            # `params.inspect` => { flower: {flower_type: ,gardener_id: , garden_id: } }
        else
            redirect_to garden_url(new_flower_params[:garden_id])
        end
    end

    def destroy
        flower = Flower.find(params[:id])
        flower.destroy
        redirect_to garden_url(flower.garden_id)

    end

    private

    def new_flower_params
        self.params.require(:flower).permit(:flower_type, :gardener_id, :garden_id)

    end
    
end