class CreateRating
  RATING_THRESHOLD = 4

  attr_reader :error_messages
  attr_reader :rating

  def initialize(params)
    @params = params
    @error_messages = []
  end
  
  def save
    user_id = @params[:user_id]
    rater_id = @params[:rater_id]
    rating_value = @params[:rating]

    begin
      user = User.find(user_id)
    rescue
      @error_messages = ["A user must be rated"]
    end

    return false if @error_messages.present?

    if user_id == rater_id 
      @error_messages = ["A user cannot rate themself"]
      return false
    end

    if user.ratings.pluck(:rater_id).include? rater_id
      @rating = Rating.where(user_id: user_id, rater_id: rater_id).first
      current_average_rating = user.average_rating
      @rating.update(rating: rating_value) if @rating.present?

      user.reload

      if current_average_rating < RATING_THRESHOLD && user.average_rating >= RATING_THRESHOLD
        create_rating_post!(user_id)
      end
    else
      @rating = Rating.new(@params.merge({ rated_at: DateTime.now }))

      unless @rating.save
        @error_messages = @rating.errors.full_messages

        return false
      end

      create_rating_post!(user_id) if rating_value >= RATING_THRESHOLD
    end

    true
  end

  private

  def create_rating_post!(user_id)
    CreatePost.new({ user_id: user_id, title: "You passed 4 stars!", body: "Congratulations!" }).save
  end
end