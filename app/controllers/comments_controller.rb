class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ destroy ]

  def create
    service = CreateComment.new(comment_params)

    if service.save
      @comment = service.comment
      response.status = 201
    else
      render_error(422, service.error_messages)
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_comment
    begin
      @comment = Comment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error(404, "Record not found")
    end
  end

  def comment_params
    # If I was implementing authentication, I would pass a token in a header
    # And use that to determine the User's id instead of allowing it to be
    # passed in directly.
    params.require(:comment).permit(:user_id, :post_id, :message)
  end
end
