class PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]

  def show
    render json: @post
  end

  def create
    service = CreatePost.new(post_params)

    if service.save
      @post = service.post
      render json: @post, status: :created, location: @post
    else
      render json: service.error_messages, status: :unprocessable_entity
    end
  end

  private

  def set_post
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error(404, "Record not found")
    end
  end

  def post_params
    # If I was implementing authentication, I would pass a token in a header
    # And use that to determine the User's id instead of allowing it to be
    # passed in directly.
    params.require(:post).permit(:title, :body, :user_id)
  end
end
