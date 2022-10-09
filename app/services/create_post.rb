class CreatePost
  attr_reader :error_messages
  attr_reader :post

  # Valid parameters are:
  #   :user_id - The id of the user making the post
  #   :title - The title of the post
  #   :body - The body of the post
  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    @post = Post.new(post_params)

    return true if @post.save

    @error_messages = @post.errors.full_messages
    false
  end

  private

  def post_params
    @params.merge({ posted_at: DateTime.now })
  end
end