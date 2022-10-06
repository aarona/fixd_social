class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  def show
    @params = post_params
    @posts = @user.posts.limit(@params[:limit]).offset(@params[:offset])

    render json: @posts
  end

  private

  def set_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error(404, "Record not found")
    end
  end

  def post_params
    {
      offset: params[:offset] ||= 0,
      limit: params[:limit] ||= 5
    }
  end
end
