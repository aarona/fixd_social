require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      title: "Test Post Title",
      body: "Test Post Body",
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      body: nil,
      user_id: nil
    }
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post posts_url, params: { post: valid_attributes }, as: :json
        }.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post posts_url, params: { post: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        data = JSON.parse(response.body)

        expect(data["post"]["title"]).to match "Test Post Title"
        expect(data["post"]["body"]).to match "Test Post Body"
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_url, params: { post: invalid_attributes }, as: :json
        }.to change(Post, :count).by(0)
      end

      it "renders a JSON response with errors for the new post" do
        post posts_url, params: { post: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "GET /show" do
    let!(:poster) { create(:user) }
    let!(:the_post) { create(:post, user: poster) }
    let!(:commenter) { create(:user) }
    let!(:comment) { create(:comment, post: the_post, user: commenter, message: "Test message") }

    it "renders a successful response" do
      get post_url(the_post), as: :json
      expect(response).to be_successful
    end

    it "returns the post and its related comments" do
      get post_url(the_post), as: :json
      data = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(data["errors"]).to be nil
      expect(data["post"]["user_id"]).to eq poster.id
      expect(data["post"]["comments"][0]["comment"]["message"]).to eq comment.message
      expect(data["post"]["comments"][0]["user"]["email"]).to eq commenter.email
    end

    context "the post does not exist" do
      before do
        the_post.destroy
      end
      
      it "returns a 404 error" do
        get post_url(the_post), as: :json
        data = JSON.parse(response.body)

        expect(response.status).to eq 404
        expect(data["errors"]).to include "Record not found"
      end
    end
  end
end
