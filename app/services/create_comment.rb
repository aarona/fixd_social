class CreateComment
  attr_reader :error_messages
  attr_reader :comment

  # Valid parameters are:
  #   :user_id - The id of the user commenting
  #   :post_id - The id of the post the user is commenting on
  #   :message - The comment the user is making
  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    @user_id = @params[:user_id]
    post_id = @params[:post_id]

    begin
      @post = Post.find(post_id)
    rescue
      @error_messages = ["A post must be commented on"]
      return false
    end
    
    @comment = Comment.new(comment_params)

    return create_comment_notification! if @comment.save

    @error_messages = @comment.errors.full_messages
    false
  end

  private

  def comment_params
    @params.merge({ commented_at: DateTime.now })
  end

  def create_comment_notification!
    CreateCommentNotification.new(comment_notification_params).save
    true
  end

  def comment_notification_params
    {
      user_id: @user_id,
      poster_id: @post.user.id
    }    
  end
end