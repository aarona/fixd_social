class CreateCommentNotification
  attr_reader :error_messages
  attr_reader :comment_notification

  # Valid parameters are:
  #   :user_id - The id of the user making the notification
  #   :poster_id - The id of the user who owns the post being commented on
  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    @comment_notification = CommentNotification.new(@params)

    return true if @comment_notification.save

    @error_messages = @comment_notification.errors.full_messages
    false
  end
end