class CreateRatingNotification
  attr_reader :error_messages
  attr_reader :rating_change

  # Valid parameters are:
  #   :user_id - The id of the user making the notification
  #   :rating - The new rating of the user
  def initialize(params)
    @params = params
    @error_messages = []
  end

  def save
    @rating_change = RatingChange.new(@params)

    return true if @rating_change.save

    @error_messages = @rating_change.errors.full_messages
    false
  end
end