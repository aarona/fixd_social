class CreatePost < CreateRecord
  # Valid parameters are:
  #   :user_id - The id of the user making the post
  #   :title - The title of the post
  #   :body - The body of the post
  def initialize(params)
    super(Post, params)
  end
end