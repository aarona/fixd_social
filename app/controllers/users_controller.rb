class UsersController < ApplicationController
  before_action :set_posts, only: %i[ show ]
  before_action :set_user, only: %i[ show ]
 
  def show; end

  private

  # Don't really need this here. Ideally, I would have a
  # FeedController (this would be the feed controller) and
  # retrieving User data would be in (this) UsersController
  def set_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error(404, "Record not found")
    end
  end
  
  def set_posts
    begin
      @posts = Post.feed(user_id: params[:id], limit: params[:limit], offset: params[:offset])
    rescue
      render_error(500, "An error occured")
    end
  end
end


