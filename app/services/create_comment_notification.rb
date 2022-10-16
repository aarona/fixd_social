class CreateCommentNotification < CreateRecord
  # Valid parameters are:
  #   :user_id - The id of the user making the notification
  #   :poster_id - The id of the user who owns the post being commented on
  def initialize(params)
    super(CommentNotification, params)
  end
end