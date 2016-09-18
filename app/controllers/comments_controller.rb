class CommentsController < ApplicationController
  authorize_actions_for Comment

  before_action :set_article, only: [:index, :create]
  before_action :set_comment, only: [:update, :destroy]

  def index
    @comments = @article.comments.order(:id)
  end

  def create
    @comment = @article.comments.build(comment_attributes)

    if @comment.save
      render_success '성공적으로 작성하였습니다.'
    else
      render_error @comment.errors.full_messages.first
    end
  end

  def update
    if @comment && @comment.update(comment_params)
      render_success '성공적으로 수정하였습니다.'
    else
      render_error @comment.errors.full_messages.first
    end
  end

  def destroy
    if @comment.destroy
      render_success '성공적으로 삭제하였습니다.'
    else
      render_error @comment.errors.full_messages.first
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize_action_for(@comment)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_attributes
    comment_params.merge(user: current_user)
  end
end
