class PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # If I was implementing authentication, I would pass a token in a header
    # And use that to determine the User's id instead of allowing it to be
    # passed in directly.
    params.require(:post).permit(:title, :body, :user_id).merge({ posted_at: DateTime.now })
  end
end
