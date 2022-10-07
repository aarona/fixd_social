class CreateRating
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
      @rating.update(rating: rating_value) if @rating.present?
    else
      @rating = Rating.new(@params.merge({ rated_at: DateTime.now }))

      unless @rating.save
        @error_messages = @rating.errors.full_messages

        return false
      end
    end

    true
  end
end