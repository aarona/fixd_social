class CreateRating < CreateRecord
  RATING_THRESHOLD = 4

  # Valid parameters are:
  #   :user_id - The id of the user being rated
  #   :rater_id - The id of user leaving the rating
  #   :rating - The rating; A integer between 1 and 5 (inclusive)
  def initialize(params)
    super(Rating, params)
  end
  
  def save
    @user_id = @params[:user_id]
    @rater_id = @params[:rater_id]
    @rating_value = @params[:rating]

    begin
      @user = User.find(@user_id)
    rescue
      @error_messages = ["A user must be rated"]
      return false
    end

    if @user_id == @rater_id 
      @error_messages = ["A user cannot rate themself"]
      return false
    end

    return update_user_rating! if user_already_rated?

    create_user_rating!
  end

  private

  def create_rating_notification!
    CreateRatingNotification.new({ user_id: @user_id, rating: RATING_THRESHOLD }).save
  end

  def create_user_rating!
    @record = Rating.new(rating_params)

    return set_error_messages! unless @record.save

    create_rating_notification! if @rating_value >= RATING_THRESHOLD
  end

  def rating_params
    @params.merge({ rated_at: DateTime.now })
  end
  
  def user_already_rated?
    @user.ratings.pluck(:rater_id).include? @rater_id
  end

  def update_user_rating!
    @record = Rating.where(user_id: @user_id, rater_id: @rater_id).first
    @current_average_rating = @user.average_rating
    @record.update(rating: @rating_value) if @record.present?
    @user.reload

    create_rating_notification! if user_met_rating_threshold?
      
    true
  end

  def user_met_rating_threshold?
    @current_average_rating < RATING_THRESHOLD && @user.average_rating >= RATING_THRESHOLD
  end
end
