class RatingsController < ApplicationController
  def create
    @rating = Rating.new(rating_params)
    
    if @rating.save
      puts "Create save called"
      render json: @rating, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    # If I was implementing authentication, I would pass a token in a header
    # And use that to determine the User's id instead of allowing it to be
    # passed in directly.
    params.require(:rating).permit(:user_id, :rater_id, :rating).merge({ rated_at: DateTime.now })
  end
end
