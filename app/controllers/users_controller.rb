class UsersController < ApplicationController
  def show
    @user = current_user
    @pets = @user.pets
  end

  def destroy
    @user = current_user
    @user.destroy
  end
end
