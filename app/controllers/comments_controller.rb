# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to report_path(@comment.commentable), notice: t('controllers.common.notice_preserve', name: Comment.model_name.human)
    else
      redirect_to report_path(@comment.commentable), alert: t('views.common.error', name: Comment.model_name.human)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if current_user == @comment.user
      @comment.destroy
      redirect_to report_path(@comment.commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      redirect_to report_path(@comment.commentable), alert: t('views.common.error', name: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end
