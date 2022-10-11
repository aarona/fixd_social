require 'rails_helper'

RSpec.describe Activity, type: :model do
  context "when created" do
    let(:post) { subject }

    it "requires user" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "User must exist"
    end
    
    it "requires loggable attributes" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Posted at can't be blank"
    end

    it "requires the time when it was posted" do
      expect(post).to_not be_valid
      expect(post.errors.full_messages).to include "Loggable must exist"
    end
  end
end
