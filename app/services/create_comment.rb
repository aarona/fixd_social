class CreateComment
  attr_reader :error_messages
  attr_reader :comment

  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    @comment = Comment.new(@params.merge({ commented_at: DateTime.now }))

    return true if @comment.save

    @error_messages = @comment.errors.full_messages
    false
  end  
end