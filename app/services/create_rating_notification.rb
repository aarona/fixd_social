class CreateRatingNotification < CreateRecord
  # Valid parameters are:
  #   :user_id - The id of the user making the notification
  #   :rating - The new rating of the user
  def initialize(params)
    super(RatingChange, params)
  end
end