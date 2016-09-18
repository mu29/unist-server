require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  before :each do
    @user = create(:user, confirmed: true)
    @other_user = create(:user, confirmed: true)
    sign_in @user
  end

  describe 'Actions' do
    it '게시글 목록' do
      5.times { create(:article) }

      get '/articles', headers: @headers
      expect(response).to be_success

      body = JSON.parse response.body
      expect(body.size).to eq 5
    end

    it '게시글 조회' do
      article = create(:article)

      get "/articles/#{article.id}", headers: @headers
      expect(response).to be_success

      body = JSON.parse response.body
      expect(body['title']).to eq article.title
      expect(body['content']).to eq article.content
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
      article.reload
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

  describe '권한' do
    it '타인의 게시글 수정 불가' do
      sign_in @other_user

      article = create(:article, user: @user)
      article_params = {
        title: Faker::Book.title,
        content: Faker::Lorem.paragraph
      }

      put "/articles/#{article.id}",
          params: { article: article_params },
          headers: @headers
      article.reload
      expect(response).not_to be_success
    end

    it '타인의 게시글 삭제 불가' do
      sign_in @other_user

      article = create(:article, user: @user)

      expect do
        delete "/articles/#{article.id}",
               headers: @headers
      end.to change(@user.articles, :count).by(0)
      expect(response).not_to be_success
    end
  end
end
