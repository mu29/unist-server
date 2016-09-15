require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "제목 없이 생성 불가" do
    article = Article.new(content: 'contents')
    assert_not article.save
  end

  test "내용 없이 생성 불가" do
    article = Article.new(title: 'title')
    assert_not article.save
  end

  test "제목과 내용 있으면 생성 가능" do
    article = Article.new(title: 'title', content: 'contents')
    assert article.save
  end
end
