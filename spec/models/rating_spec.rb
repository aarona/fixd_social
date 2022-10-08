require 'rails_helper'

RSpec.describe Rating, type: :model do
  context "when created" do
    let(:rating) { subject }

    it "requires a user that rates" do
      expect(rating).to_not be_valid
      expect(rating.errors.full_messages).to include "User must exist"
    end

    it "requires a user that is rated" do
      expect(rating).to_not be_valid
      expect(rating.errors.full_messages).to include "Rater must exist"
    end

    it "requires a rating" do
      expect(rating).to_not be_valid
      expect(rating.errors.full_messages).to include "Rating can't be blank"
    end
    
    it "requires a time that the rating occurred" do
      expect(rating).to_not be_valid
      expect(rating.errors.full_messages).to include "Rated at can't be blank"
    end
  end

  context "when a user has rated another" do
    let(:rating_user) { create(:user) }
    let(:rated_user) { create(:user) }
    let(:rating) { build(:rating, rater: rating_user, user: rated_user )}

    it "the rated user's ratings should increase by one" do
      expect {
        rating.save
      }.to change(rated_user.ratings, :count).by(1)
    end

    it "should have a rating between 1 and 5" do
      rating.rating = 0
      expect(rating).to_not be_valid
 
      rating.rating = 6
      expect(rating).to_not be_valid
 
      rating.rating = 5
      expect(rating).to be_valid
    end
    
  end

  context "when a user is rated a 5 and rated a 3" do
    let(:user) { create(:user) }

    before do
      create(:rating, user: user, rating: 5)
      create(:rating, user: user, rating: 3)
    end

    it "should have 2 ratings" do
      expect(user.ratings.count).to eq 2
    end
    
    it "should have an average rating of 4" do
      expect(user.average_rating).to eq 4
    end
  end  
end
