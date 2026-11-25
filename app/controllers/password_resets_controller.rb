class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      PasswordMailer.with(user: user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email exists, you will receive password reset instructions"
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: :password_reset)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, alert: "Invalid or expired password reset token"
  end

  def update
    @user = User.find_signed!(params[:token], purpose: :password_reset)
    @user.assign_attributes(password_params)
    if @user.save(context: :password_change)
      redirect_to root_path, notice: "Password has been reset successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, alert: "Invalid or expired password reset token"
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
