require 'rails_helper'

RSpec.describe RatingChange, type: :model do
  context "when created" do
    let(:rating_change) { subject }

    it "requires a rating" do
      expect(rating_change).to_not be_valid
      expect(rating_change.errors.full_messages).to include "Rating can't be blank"
    end

    it "requires a user" do
      expect(rating_change).to_not be_valid
      expect(rating_change.errors.full_messages).to include "User must exist"
    end
  end

  context "when creating a rating change notification" do
    let(:rating_change) { build(:rating_change) }

    it "should have an associated activity with it" do
      expect {
        rating_change.save
      }.to change(Activity, :count).by(1)

      activity = Activity.last

      expect(rating_change.id).to eq activity.loggable_id
      expect(activity.loggable_type).to eq "RatingChange"
    end
  end

  context "when a rating change notification is destroyed" do
    let(:rating_change) { create(:rating_change) }
    let(:activity) { rating_change.activity }

    before do
      rating_change.destroy
    end

    it "the associated activity should also be deleted" do
      expect(activity).to be_destroyed
    end
  end
end
