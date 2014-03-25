class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Say hello to your new wishlist!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:fname, :lname, :email, :password,
  			                           :password_confirmation)
  	end
end
