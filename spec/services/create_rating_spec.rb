require 'rails_helper'

RSpec.describe CreateRating do
  describe "#save" do
    context "when params are valid" do
      let(:user_id) { create(:user).id }
      let(:rater_id) { create(:user).id }
      let(:params) { { user_id: user_id, rater_id: rater_id, rating: 5 } }
      let(:create_rating) { CreateRating.new(params) }

      it "should save return true" do
        expect(create_rating.save).to be true
      end

      it "should have no error messages" do
        create_rating.save
        expect(create_rating.error_messages).to be_empty
      end
    end

    context "where no user is supplied" do
      let(:rater_id) { create(:user).id }
      let(:params) { { user_id: nil, rater_id: rater_id, rating: 5 } }
      let(:create_rating) { CreateRating.new(params) }

      it "should return false" do
        expect(create_rating.save).to be false
      end
      
      it "should have an error message" do
        create_rating.save
        expect(create_rating.error_messages).to include "A user must be rated"
      end
    end

    context "when the user is attempting to rate themself" do
      let(:rater_id) { create(:user).id }
      let(:params) { { user_id: rater_id, rater_id: rater_id, rating: 5 } }
      let(:create_rating) { CreateRating.new(params) }

      it "should reutn false" do
        expect(create_rating.save).to be false
      end

      it "should have an error message" do
        create_rating.save
        expect(create_rating.error_messages).to include "A user cannot rate themself"
      end
    end

    context "when the user is attempting rerate another user" do
      let(:user_id) { create(:user).id }
      let(:rater_id) { create(:user).id }
      let(:create_rating) { CreateRating.new({ user_id: user_id, rater_id: rater_id, rating: 3 }) }

      before do
        CreateRating.new({ user_id: user_id, rater_id: rater_id, rating: 5 }).save
      end

      it "no new ratings should be created" do
        expect {
          create_rating.save
        }.to change(Rating, :count).by(0)
      end

      it "the existing rating should be updated" do
        create_rating.save
        expect(create_rating.rating.rating).to eq 3
      end
    end

    context "when a user receives their first rating and its over 4 stars" do
      let(:user) { create(:user) }
      let(:rater) { create(:user) }
      
      it "should create a rating notifiction announcing this" do
        expect {
          CreateRating.new({ user_id: user.id, rater_id: rater.id, rating: 4}).save
        }.to change(RatingChange, :count).by(1)

        rating_change = RatingChange.last

        expect(rating_change.rating).to eq 4
      end
    end

    context "when a user's average rating goes above 4 stars" do
      let(:user) { create(:user) }
      let(:rater_1) { create(:user) }
      let(:rater_2) { create(:user) }

      before do
        CreateRating.new({ user_id: user.id, rater_id: rater_1.id, rating: 3}).save
      end
      
      it "should create a rating notification announcing this" do
        expect {
          CreateRating.new({ user_id: user.id, rater_id: rater_2.id, rating: 5}).save
        }.to change(RatingChange, :count).by(1)

        rating_change = RatingChange.last

        expect(rating_change.rating).to eq 4
      end
    end
  end
end
