class UsersController < ApplicationController

    def new 
        render :new 
    end

    def create 
        new_user = User.create(new_user_params) 
        
        if new_user.save
            redirect_to gardens_url 
            # specs, then rails routes to find prefix + _url 
        else
            render :new
            # render does not need +_url 
        end
    end

    private

    def new_user_params
        self.params.require(:user).permit(:username)
    end





end