class RatingsController < ApplicationController
  def create
    service = CreateRating.new(rating_params)
    
    if service.save
      @rating = service.rating

      render json: @rating, status: :created
    else
      render json: service.error_messages, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    # If I was implementing authentication, I would pass a token in a header
    # And use that to determine the User's id instead of allowing it to be
    # passed in directly.
    params.require(:rating).permit(:user_id, :rater_id, :rating)
  end
end
