require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  before :each do
    @user = create(:user, confirmed: true)
    @other_user = create(:user, confirmed: true)
    @article = create(:article, user: @user)
    sign_in @user
  end

  it '덧글 작성' do
    comment_params = { content: Faker::Lorem.paragraph }

    expect do
      post "/articles/#{@article.id}/comments",
           params: { comment: comment_params },
           headers: @headers
    end.to change(@user.comments, :count).by(1)
    expect(response).to be_success
  end

  it '본인의 덧글 수정 가능' do
    comment = create(:comment, user: @user)
    comment_params = { content: Faker::Lorem.paragraph }

    put "/articles/#{comment.article.id}/comments/#{comment.id}",
        params: { comment: comment_params },
        headers: @headers
    comment.reload
    expect(response).to be_success
    expect(comment.content).to eq comment_params[:content]
  end

  it '타인의 덧글 수정 불가' do
    sign_in @other_user

    comment = create(:comment, user: @user)
    comment_params = { content: Faker::Lorem.paragraph }

    put "/articles/#{comment.article.id}/comments/#{comment.id}",
        params: { comment: comment_params },
        headers: @headers
    comment.reload
    expect(response).not_to be_success
  end

  it '본인의 덧글 삭제 가능' do
    comment = create(:comment, user: @user)

    expect do
      delete "/articles/#{comment.article.id}/comments/#{comment.id}",
             headers: @headers
    end.to change(@user.comments, :count).by(-1)
    expect(response).to be_success
  end

  it '타인의 덧글 삭제 불가' do
    sign_in @other_user

    comment = create(:comment, user: @user)

    expect do
      delete "/articles/#{comment.article.id}/comments/#{comment.id}",
             headers: @headers
    end.to change(@user.comments, :count).by(0)
    expect(response).not_to be_success
  end
end
