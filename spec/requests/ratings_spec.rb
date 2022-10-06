require 'rails_helper'

RSpec.describe "Ratings", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:rater) { FactoryBot.create(:user) }

  # This should return the minimal set of attributes required to create a valid
  # Rating. As you add validations to Rating, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      user_id: user.id,
      rater_id: rater.id,
      rating: 5
    }
  }

  let(:invalid_attributes) {
    {
      user_id: nil,
      rater_id: nil,
      rating: 0
    }
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Rating" do
        expect {
          post ratings_url, params: { rating: valid_attributes }, as: :json
        }.to change(Rating, :count).by(1)
      end

      it "renders a JSON response with the new rating" do
        post ratings_url, params: { rating: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Rating" do
        expect {
          post ratings_url,
               params: { rating: invalid_attributes }, as: :json
        }.to change(Rating, :count).by(0)
      end

      it "renders a JSON response with errors for the new rating" do
        post ratings_url, params: { rating: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
