require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  before :each do
    @user = create(:user, confirmed: true)
    sign_in @user
  end

  it '게시글 작성' do
    article_params = {
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph
    }

    expect do
      post '/articles',
           params: { article: article_params },
           headers: @headers
    end.to change(@user.articles, :count).by(1)
    expect(response).to be_success
  end

  it '게시글 수정' do
    article = create(:article, user: @user)
    article_params = {
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph
    }

    put "/articles/#{article.id}",
        params: { article: article_params },
        headers: @headers
    expect(response).to be_success
    expect(article.title).to eq article_params[:title]
    expect(article.content).to eq article_params[:content]
  end

  it '게시글 삭제' do
    article = create(:article, user: @user)

    expect do
      delete "/articles/#{article.id}",
             headers: @headers
    end.to change(@user.articles, :count).by(-1)
    expect(response).to be_success
  end
end
