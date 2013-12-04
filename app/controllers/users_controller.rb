class UsersController < ApplicationController

	def new
		@user = User.new		
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user
		end
		user = User.find_by(email: params[:user][:email])
		if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect_to user
    end
	end

	def show
    @user = User.find(params[:id])
  end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :confirm_password)
	end

end