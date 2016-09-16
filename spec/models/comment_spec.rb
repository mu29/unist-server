require 'rails_helper'

RSpec.describe Comment, :type => :model do
  context '유효성 검사' do
    before :each do
      @user = create(:user)
      @article = create(:article)
    end

    it '내용이 있는 경우 생성 가능' do
      comment = @article.comments.build(content: Faker::Lorem.sentence, user: @user)
      expect(comment.save).to eq true
    end

    it '내용 없는 경우 생성 불가' do
      comment = @article.comments.build
      expect(comment.save).to eq false
    end

    it '게시글 없는 경우 생성 불가' do
      comment = Comment.new(content: Faker::Lorem.paragraph, user: @user)
      expect(comment.save).to eq false
    end
  end
end
