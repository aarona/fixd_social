require 'rails_helper'

RSpec.describe Post, type: :model do
  context "when created" do
    let(:post) { subject }

    it "requires a title" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Title can't be blank"
    end

    it "requires a body" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Body can't be blank"
    end

    it "requires a user" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "User must exist"
    end
  end

  context "when creating a post" do
    let(:post) { build(:post) }

    it "should have an associated activity with it" do
      expect {
        post.save
      }.to change(Activity, :count).by(1)

      activity = Activity.last

      expect(post.id).to eq activity.loggable_id
      expect(activity.loggable_type).to eq "Post"
    end
  end

  context "when a post is destroyed" do
    let(:post) { create(:post) }
    let(:activity) { post.activity }

    before do
      post.destroy
    end

    it "the associated activity should also be deleted" do
      expect(activity).to be_destroyed
    end
  end
end
