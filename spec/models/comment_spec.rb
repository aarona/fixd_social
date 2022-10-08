require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "when created" do
    let(:comment) { subject }

    it "requires a user" do
      expect(comment).to_not be_valid
      expect(comment.errors.full_messages).to include "User must exist"
    end

    it "requires a post" do
      expect(comment).to_not be_valid
      expect(comment.errors.full_messages).to include "Post must exist"
    end

    it "requires a message" do
      expect(comment).to_not be_valid
      expect(comment.errors.full_messages).to include "Message can't be blank"
    end

    it "requires a time when it was commented" do
      expect(comment).to_not be_valid
      expect(comment.errors.full_messages).to include "Commented at can't be blank"
    end
  end

  context "when a post has multiple comments" do
    let(:commented_at) { DateTime.now }
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let!(:first_comment) { fc = create(:comment, post: post) }
    let!(:second_comment) { create(:comment, post: post) }
    let!(:third_comment) { create(:comment, post: post) }

    context "and a comment has been deleted and new one added" do
      before do
        first_comment.destroy
        create(:comment, post: post)
        post.reload
      end
  
      it "they should be in order by the time they were commented at" do
        expect(post.comments.count).to eq 3
        expect(post.comments.first.id).to eq second_comment.id
      end
    end

    context "when the post is deleted" do
      it "the comments associated with the post shouild also be deleted" do
        expect {
          post.destroy
        }.to change(Comment, :count).by(-3)
      end
    end
  end
end
