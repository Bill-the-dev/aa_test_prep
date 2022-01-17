class GardensController < ApplicationController

    def index
        @gardens = Garden.all #set before so .erb can reference
        render :index 
    end

    def show 
        @garden = Garden.find(self.params[:id])
          #ref the routes for params arg 
        render :show 
    end

    def create 
        new_garden = Garden.create(new_garden_params)  #does not like self!!

        if new_garden.save 
            redirect_to gardens_url
        else
            render :new 
        end
    end

    private 

    def new_garden_params
        self.params.require(:garden).permit(:name, :size, :garden_owner_id)
    end

end
