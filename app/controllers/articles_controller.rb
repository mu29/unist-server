class ArticlesController < ApplicationController
  authorize_actions_for Article

  skip_before_action :verify_authenticate_token, only: [:index]
  before_action :set_article, only: [:update, :destroy]

  def index
    @articles = Article.order(:id).page(params[:page])
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      render_success '성공적으로 작성하였습니다.'
    else
      render_error @article.errors.full_messages.first
    end
  end

  def update
    if @article && @article.update(article_params)
      render_success '성공적으로 수정하였습니다.'
    else
      render_error @article.errors.full_messages.first
    end
  end

  def destroy
    if @article.destroy
      render_success '성공적으로 삭제하였습니다.'
    else
      render_error @article.errors.full_messages.first
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
    authorize_action_for(@article)
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
