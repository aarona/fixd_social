class CreatePost
  attr_reader :error_messages
  attr_reader :post

  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    @post = Post.new(@params.merge({ posted_at: DateTime.now }))

    return true if @post.save

    @error_messages = @post.errors.full_messages
    false
  end  
end