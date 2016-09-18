require 'rails_helper'

RSpec.describe Article, type: :model do
  context '유효성 검사' do
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

    it '작성자 없는 경우 생성 불가' do
      article = Article.new(title: Faker::Book.title, content: Faker::Lorem.paragraph)
      expect(article.save).to eq false
    end
  end

  context '카테고리' do
    before :each do
      @article = create(:article)
      @category = Faker::Lorem.word
      @article.category_list.add(@category)
      @article.save
    end

    it '추가' do
      category = Faker::Lorem.word
      @article.category_list.add(category)
      @article.save

      expect(Article.with_category(@category).size).to eq 1
      expect(@article.categories.size).to eq 2
      expect(@article.category_list.include?(category)).to eq true
      expect(@article.categories.pluck(:name).include?(category)).to eq true
    end

    it '삭제' do
      @article.category_list.remove(@category)
      @article.save

      expect(Article.with_category(@category).size).to eq 0
      expect(@article.categories.size).to eq 0
    end
  end
end
