class CreateComment
  attr_reader :error_messages
  attr_reader :comment

  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    user_id = @params[:user_id]
    post_id = @params[:post_id]

    begin
      post = Post.find(post_id)
    rescue
      @error_messages = ["A post must be commented on"]
    end

    return false if @error_messages.present?
    
    @comment = Comment.new(@params.merge({ commented_at: DateTime.now }))

    if @comment.save
      CreatePost.new(post_comment_params(user_id, post)).save
      return true
    end

    @error_messages = @comment.errors.full_messages
    false
  end

  private

  def post_comment_params(user_id, original_post)
    {
      user_id: user_id,
      title: "Commented on a post by #{original_post.user.name}",
      # Taking a short cut here. I made the body a required field.
      # In certain circumstances maybe it shouldn't be like this case.
      # Decided to use the orgiinal post's URL as the body.
      body: "/posts/#{original_post.id}"
    }    
  end
end