class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: %i[ show update destroy]
    before_action :check_owner, only: %i[ update destroy]

    def show
        options = { include: [:products] }
        render json: UserSerializer.new(@user).serializable_hash
    end

    def create
        @user = User.new(user_params)
        if(@user.save)
            render json: UserSerializer.new(@user).serializable_hash, status: :created
        else
            render json: @user, status: :unprocessable_entity
        end
    end

    #  the update action responds to a PUT/PATCH request only.

    def update
        if @user.update(user_params)
            render json: UserSerializer.new(@user).serializable_hash
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        head 204
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def check_owner
        head :forbidden unless @user.id = current_user&.id
    end
end


#  an api does not handle sessions.
#  an api is stateless that means it always follow request and then it will give response and then requires no 
#  further attention. which means no previous or future state is required.
#  introducing JWT(Json web token) it will exchanges the security tokens between several parties.
#  JWT composed of three parts
# header : the validaity date of the token
# payload is a  structured in JSON can contain any data, in our case, it will contain the identifier of the "connected user".
# a signature allows us to verify that the token has been 
# encrypted by our application and is therefore valid.
#  these three parts will combined with dot(.)
#  example of "header.payload.signature" that is a encrypted token
#  so we are setting up the authentication using JWT token