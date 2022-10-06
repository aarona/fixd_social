require 'rails_helper'

RSpec.describe "Comments", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:user) { FactoryBot.create(:user) }
  let(:new_post) { FactoryBot.create(:post) }

  let(:valid_attributes) {
    {
      user_id: user.id,
      post_id: new_post.id,
      message: "Test Comment Message"
    }
  }

  let(:invalid_attributes) {
    {
      user_id: nil,
      post_id: nil,
      message: nil
    }
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post comments_url, params: { comment: valid_attributes }, as: :json
        }.to change(Comment, :count).by(1)
      end

      it "renders a JSON response with the new comment" do
        post comments_url, params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post comments_url, params: { comment: invalid_attributes }, as: :json
        }.to change(Comment, :count).by(0)
      end

      it "renders a JSON response with errors for the new comment" do
        post comments_url, params: { comment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:comment) { FactoryBot.create(:comment) }

    it "destroys the requested comment" do
      expect {
        delete comment_url(comment), as: :json
      }.to change(Comment, :count).by(-1)
    end

    context "the comment does not exist" do
      before do
        comment.destroy
      end

      it "does not destroy anything" do
        expect {
          delete comment_url(comment), as: :json
        }.to change(Comment, :count).by(0)
      end
      
      it "returns a 404 error" do
        delete comment_url(comment), as: :json
        data = JSON.parse(response.body)

        expect(response.status).to eq 404
        expect(data["errors"]).to include "Record not found"
      end
    end
  end
end
