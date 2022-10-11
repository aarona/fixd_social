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

    # it "requires a time when it was posted" do
    #   expect(post).to_not be_valid
    #   expect(post.errors.full_messages).to include "Posted at can't be blank"
    # end
  end
end
