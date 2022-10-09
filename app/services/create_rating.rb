class CreateRating
  RATING_THRESHOLD = 4

  attr_reader :error_messages
  attr_reader :rating

  # Valid parameters are:
  #   :user_id - The id of the user being rated
  #   :rater_id - The id of user leaving the rating
  #   :rating - The rating; A integer between 1 and 5 (inclusive)
  def initialize(params)
    @params = params
    @error_messages = []
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

  def create_rating_post!
    CreatePost.new({ user_id: @user_id, title: "You passed 4 stars!", body: "Congratulations!" }).save
  end

  def create_user_rating!
    @rating = Rating.new(rating_params)

    unless @rating.save
      @error_messages = @rating.errors.full_messages

      return false
    end

    create_rating_post! if @rating_value >= RATING_THRESHOLD

    true
  end

  def rating_params
    @params.merge({ rated_at: DateTime.now })
  end
  
  def user_already_rated?
    @user.ratings.pluck(:rater_id).include? @rater_id
  end

  def update_user_rating!
    @rating = Rating.where(user_id: @user_id, rater_id: @rater_id).first
    @current_average_rating = @user.average_rating
    @rating.update(rating: @rating_value) if @rating.present?
    @user.reload

    create_rating_post! if user_met_rating_threshold?
      
    true
  end

  def user_met_rating_threshold?
    @current_average_rating < RATING_THRESHOLD && @user.average_rating >= RATING_THRESHOLD
  end
end
