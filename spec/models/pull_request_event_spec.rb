require 'rails_helper'

RSpec.describe PullRequestEvent, type: :model do
    context "when created" do
    let(:post) { subject }

    it "requires an event_id" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Event can't be blank"
    end

    it "requires a user" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "User must exist"
    end

    it "requires a number" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Number can't be blank"
    end

    it "requires a repo" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Repo can't be blank"
    end

    it "requires a created_at time" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Created at can't be blank"
    end

    context "when an existing event with the same event_id exists" do
      let(:existing_event_id) { 5 }
      let!(:existing_event) { create(:pull_request_event, event_id: existing_event_id) }
      let(:event) { build(:pull_request_event, event_id: existing_event_id) }

      it "requires the event_id to be unique" do
        expect(event).to_not be_valid
        expect(event.errors.full_messages).to include "Event must be unique"
      end
    end
  end
end
