require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe '로그인' do
    before :each do
      @password = Faker::Internet.password
      @user = create(:user, password: @password)
    end

    it '메일 주소와 비밀번호가 일치하는 경우 성공' do
      session_params = {
        email: @user.email,
        password: @password
      }
      post '/sessions',
           params: { session: session_params }
      expect(response).to be_success

      body = JSON.parse response.body
      user = User.find(JsonWebToken.decode(body['token'])[:user_id])
      expect(user).to eq @user
    end

    it '메일 주소가 없는 경우 실패' do
      session_params = {
        email: Faker::Internet.email,
        password: @password
      }
      post '/sessions',
           params: { session: session_params }
      expect(response).not_to be_success
    end

    it '비밀번호가 틀릴 경우 실패' do
      session_params = {
        email: @user.email,
        password: Faker::Internet.password
      }
      post '/sessions',
           params: { session: session_params }
      expect(response).not_to be_success
    end
  end
end
