require 'rails_helper'

RSpec.describe CreateComment do
  describe "#save" do
    let!(:original_poster) { create(:user) }
    let!(:post) { create(:post, user: original_poster) }
    let(:commenter) { create(:user) }

    let(:valid_attributes) {
      {
        user_id: commenter.id,
        post_id: post.id,
        message: "Test Comment Message"
      }
    }

    context "when params are valid" do
      let(:create_comment) { CreateComment.new(valid_attributes) }

      it "should save return true" do
        expect(create_comment.save).to be true
      end

      it "should have no error messages" do
        create_comment.save
        expect(create_comment.error_messages).to be_empty
      end

      it "creates a post on the user's feed about the comment" do
        expect {
          create_comment.save
        }.to change(CommentNotification, :count).by(1)

        comment_notification = CommentNotification.where(user_id: commenter.id).last
  
        expect(comment_notification.user.id).to be commenter.id
      end
    end

    # To save time and get this submitted, I've skipped tests for failures. To seem examples
    # of what that might these tests might look like, review the spec tests for CreateRating. 
  end
end
