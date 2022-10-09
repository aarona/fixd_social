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

    return create_comment_post! if @comment.save

    @error_messages = @comment.errors.full_messages
    false
  end

  private

  def comment_params
    @params.merge({ commented_at: DateTime.now })
  end

  def create_comment_post!
    CreatePost.new(post_comment_params).save
    true
  end

  # Taking a short cut here. I made the body a required field.
  # In certain circumstances maybe it shouldn't be like this case.
  # Decided to use the orgiinal post's URL as the body.
  def post_comment_params
    {
      user_id: @user_id,
      title: "Commented on a post by #{@post.user.name}",
      body: "/posts/#{@post.id}"
    }    
  end
end