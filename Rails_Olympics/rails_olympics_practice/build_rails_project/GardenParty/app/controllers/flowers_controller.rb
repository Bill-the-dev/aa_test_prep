class FlowersController < ApplicationController

    def create 
        new_flower = Flower.create(new_flower_params)
        redirect_to garden_url(new_flower.garden)
    end

    def destroy 
        d_flower = Flower.find(params[:id])
        d_flower.destroy 
        redirect_to garden_url(d_flower.garden_id)
    end



    private 

    def new_flower_params
        self.params.require(:flower).permit(:flower_type, :gardener_id, :garden_id)
    end

end
