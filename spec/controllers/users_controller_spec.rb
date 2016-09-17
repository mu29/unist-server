require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe '회원가입' do
    before :each do
      @user_params = {
        email: Faker::Internet.email,
        password: Faker::Internet.password,
        name: Faker::Name.name
      }
      post '/users',
           params: { user: @user_params }
      expect(response).to be_success
    end

    it '회원가입 후 메일 보내기' do
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to).to eq [@user_params[:email]]
    end

    it '회원가입 후 confirm_token 생성하기' do
      user = User.last
      expect(user.confirm_token.present?).to eq true
    end
  end
end
