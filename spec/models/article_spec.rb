require 'rails_helper'

RSpec.describe Article, :type => :model do
  context '생성' do
    before :each do
      @user = create(:user)
    end

    it '제목, 내용이 있는 경우 생성 가능' do
      article = @user.articles.build(title: Faker::Book.title, content: Faker::Lorem.paragraph)
      expect(article.save).to eq true
    end

    it '제목 없는 경우 생성 불가' do
      article = @user.articles.build(content: Faker::Lorem.paragraph)
      expect(article.save).to eq false
    end

    it '내용 없는 경우 생성 불가' do
      article = @user.articles.build(title: Faker::Book.title)
      expect(article.save).to eq false
    end
  end
end
