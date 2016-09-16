require 'rails_helper'

RSpec.describe User, :type => :model do
  context '생성' do
    before :each do
      @user = User.new
    end

    it '메일 주소, 비밀번호, 이름이 있는 경우 생성 가능' do
      @user.email = Faker::Internet.email
      @user.password = Faker::Internet.password
      @user.name = Faker::Name.name
      expect(@user.save).to eq true
    end

    it '메일 주소 없는 경우 생성 불가' do
      @user.name = Faker::Name.name
      @user.password = Faker::Internet.password
      expect(@user.save).to eq false
    end

    it '비밀번호 없는 경우 생성 불가' do
      @user.email = Faker::Internet.email
      @user.name = Faker::Name.name
      expect(@user.save).to eq false
    end

    it '이름 없는 경우 생성 불가' do
      @user.email = Faker::Internet.email
      @user.password = Faker::Internet.password
      expect(@user.save).to eq false
    end
  end
end
