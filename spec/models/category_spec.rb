require 'rails_helper'

RSpec.describe Category, :type => :model do
  context '유효성 검사' do
    it '이름 있는 경우 생성 가능' do
      category = Category.new(name: Faker::Lorem.word)
      expect(category.save).to eq true
    end

    it '이름 없는 경우 생성 불가' do
      category = Category.new
      expect(category.save).to eq false
    end
  end

  it '게시글에 카테고리 추가 가능' do
    category = create(:category)
    article = create(:article)
    article.categories << category
    expect(article.categories.pluck(:name).include?(category.name)).to eq true
  end
end
