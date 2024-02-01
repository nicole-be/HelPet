class UsersController < ApplicationController
  def show
    @user = current_user
    @pets = @user.pets
  end
end
