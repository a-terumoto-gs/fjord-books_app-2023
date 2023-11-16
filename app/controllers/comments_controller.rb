# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back(fallback_location: root_path, notice: t('controllers.common.notice_preserve', name: Comment.model_name.human))
    else
      redirect_back(fallback_location: root_path, alert: t('views.common.validation_error', name: Comment.model_name.human, errors: Comment.model_name.human))
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if current_user == @comment.user
      @comment.destroy
      redirect_back(fallback_location: root_path, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human))
    else
      redirect_back(fallback_location: root_path, alert: t('views.common.validation_error', name: Comment.model_name.human))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end
