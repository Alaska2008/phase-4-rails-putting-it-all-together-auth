class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username] )
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: {login: "Not Authorized"}}, status: :unauthorized
        end    
    end

    def destroy
        user = User.find(session[:user_id])
        if user
            session.delete :user_id
            head :no_content
        else
            render json: {errors: "Not Authorrized" }, status: :unauthorized   
        end 
        
    end 

    
end
