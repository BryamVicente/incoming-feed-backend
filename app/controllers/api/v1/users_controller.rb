class Api::V1::UsersController < ApplicationController

    skip_before_action :authorized, only: [:show, :create, :index ]

    def index
        users = User.all
        render json: users
    end 

    def show 
        my_user = User.find(params[:id])
        render json: my_user 
    end 

    def create 
        my_user = User.create(user_params)
        if my_user.valid?
            token = encode_token(user_id: my_user.id)
            render json: {user: UserSerializer.new(my_user), jwt: token }, status: :created
        else 
            render json: {error: 'failed to create user'}, status: :not_acceptable
        end 
    end 

    def profile
        render json: {user: UserSerializer.new(current_user)}, status: :accepted
    end     

    private

    def user_params
        params.permit(:username, :name, :email, :image, :password)
    end 

end
