class PasswordsController < ApplicationController
  before_action :require_user_logged_in

  def edit
  end

  def update
    Current.user.assign_attributes(password_params)
    if Current.user.save(context: :password_change)
      redirect_to root_path, notice: "Password updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
