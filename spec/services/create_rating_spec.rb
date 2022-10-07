require 'rails_helper'

RSpec.describe CreateRating do
  describe "#save" do
    context "when params are valid" do
      let(:user_id) { FactoryBot.create(:user).id }
      let(:rater_id) { FactoryBot.create(:user).id }
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
      let(:rater_id) { FactoryBot.create(:user).id }
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
      let(:rater_id) { FactoryBot.create(:user).id }
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
      let(:user_id) { FactoryBot.create(:user).id }
      let(:rater_id) { FactoryBot.create(:user).id }
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
  end
end
