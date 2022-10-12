require 'rails_helper'

RSpec.describe CommentNotification, type: :model do
    context "when created" do
    let(:comment_notification) { subject }

    it "requires a user" do
      expect(comment_notification).to_not be_valid
      expect(comment_notification.errors.full_messages).to include "User must exist"
    end

    it "requires a poster" do
      expect(comment_notification).to_not be_valid
      expect(comment_notification.errors.full_messages).to include "Poster must exist"
    end
  end

  context "when creating a comment notification" do
    let!(:comment_notification) { build(:comment_notification) }

    it "should have an associated activity with it" do
      activity = nil
      expect {
        comment_notification.save
        activity = comment_notification.activity
      }.to change(Activity, :count).by(1)

      expect(comment_notification.id).to eq activity.loggable_id
      expect(activity.loggable_type).to eq "CommentNotification"
    end
  end

  context "when a comment notification is destroyed" do
    let(:comment_notification) { create(:comment_notification) }
    let(:activity) { comment_notification.activity }

    before do
      comment_notification.destroy
    end

    it "the associated activity should also be deleted" do
      expect(activity).to be_destroyed
    end
  end
end
