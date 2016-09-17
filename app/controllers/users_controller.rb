class UsersController < ApplicationController
  skip_before_action :verify_authenticate_token

  def create
    @user = User.new(user_params)

    if @user.save
      render_success '회원가입에 성공하였습니다', {}, :created
    else
      render_error @user.errors.full_messages.first
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
